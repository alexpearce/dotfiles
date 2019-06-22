"""YouCompleteMe configuration tailored for LHCb stack development.

This files logs to the same location as the YouCompleteMe Python machinery,
which defaults to the stderr file reported by :YcmDebugInfo.
"""
from __future__ import print_function
import datetime
import glob
import logging
import os
import sys

import ycm_core

log = logging.getLogger('ycm_extra_conf')

# Flags to be used if we can't find a compilation DB
DEFAULT_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-std=c++17',
    '-x', 'c++',
    '-I', '.',
    '-isystem', '/usr/local/include',
    '-isystem', '/usr/include'
]
HEADER_EXTENSIONS = ['.h', '.hxx', '.hpp', '.hh']
SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']


def is_header(filename):
  _, extension = os.path.splitext(filename)
  return extension in HEADER_EXTENSIONS


def is_source(filename):
  _, extension = os.path.splitext(filename)
  return extension in SOURCE_EXTENSIONS


def source_file(filename):
    """Try to find the source file corresponding to the header."""
    if is_source(filename):
        return filename

    basename, _ = os.path.splitext(filename)
    for extension in SOURCE_EXTENSIONS:
        replacement_file = basename + extension
        if os.path.exists(replacement_file):
            return replacement_file

    # TODO: look for source files elsewhere, e.g. go one directory up and walk
    # around trying to find something with a matching name
    # Inspiration: https://gist.github.com/dominikmuller/7239680d3f51d822ecfee0fd227406cd

    # Couldn't find anything, so return the original file
    return filename


def find_database(filename):
    """Return the compilation database corresponding to this file."""
    current_dir = os.path.dirname(filename)
    # Walk up the directory tree until we find a CMakeLists, then search for a
    # DB file in the last-modified build directory next to the CMake file
    # If not DB is found, keep walking
    while 'upgrade-hackathon-setup' in current_dir:
        log.info('Walking %s', current_dir)
        if os.path.exists(os.path.join(current_dir, 'CMakeLists.txt')):
            log.info('Found CMakeLists.txt')
            build_dirs = glob.glob(os.path.join(current_dir, 'build.*'))
            if build_dirs:
                latest_build = sorted(build_dirs, key=os.path.getmtime)[-1]
                log.info('Found build directory: %s', latest_build)
                db = os.path.join(latest_build, 'compile_commands.json')
                if os.path.exists(db):
                    log.info('Found DB: %s', db)
                    # Must pass the containing folder, not the file
                    return ycm_core.CompilationDatabase(latest_build)
            else:
                log.info('No build directory found')
        # Go up another level
        current_dir = os.path.dirname(current_dir)


def Settings(**kwargs):
    """Return a configuration dictionary for the current file.

    A compilation database is searched for using the path of the current file.
    Compilation flags are taken from the DB if found, other the DEFAULT_FLAGS
    are used. Compilation flags for header files are found by first searching
    for an nearby source file which is hopefully related to the header, and
    then using the flags defined for that source file.
    """
    start = datetime.datetime.now()

    default_settings = {}
    if kwargs['language'] != 'cfamily':
        return {}

    filename = source_file(kwargs['filename'])
    log.info('Original filename: %s', kwargs['filename'])
    log.info('Resolved filename: %s', filename)
    if 'upgrade-hackathon-setup' in filename:
        log.info('Finding DB...')
        database = find_database(filename)
        if database is None:
            log.info('Not found')
            return default_settings

    compilation_info = database.GetCompilationInfoForFile(filename)

    flags = list(compilation_info.compiler_flags_)
    if not flags:
        # TODO: can probably do better than this
        return dict(flags=DEFAULT_FLAGS)
    else:
        log.info('Flags: %s', compilation_info.compiler_flags_)
        log.info('Working directory: %s', compilation_info.compiler_working_dir_)

    end = datetime.datetime.now()
    elapsed = end - start
    log.info('Took %f seconds', elapsed.total_seconds())

    return dict(
        flags=flags,
        include_paths_relative_to_dir=compilation_info.compiler_working_dir_,
        override_filename=filename
    )
