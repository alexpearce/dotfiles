starship init fish | source

set -l source_dir (dirname (status -f))

source $source_dir/env.fish
source $source_dir/aliases.fish
source $source_dir/git.fish
source $source_dir/kerberos.fish
source $source_dir/conda.fish
source $source_dir/iterm2_shell_integration.fish
