Dotfiles
========

This is my collection of [configuration files](http://dotfiles.github.io/).

Usage
-----

The `fish` dotfiles depend on [the fish shell](http://fishshell.com),
so install that first:

```bash
$ brew install fish
# Add /usr/local/bin/fish to /etc/shells, then do
$ chsh -s /usr/local/bin/fish
```

Pull the repository, and then create the symbolic links using [GNU
stow](https://www.gnu.org/software/stow/).

```bash
$ git clone git@github.com:alexpearce/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow fish vim tmux # plus whatever else you'd like
```

There are two terminfo files in the `terminfo` directory.  These are for
[enabling italics in iTerm2, vim, and
tmux](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/).
They are not added automatically.

License
-------

[MIT](http://opensource.org/licenses/MIT).
