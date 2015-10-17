# Git state
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch 666
set __fish_git_prompt_color_dirtystate magenta
set __fish_git_prompt_color_stashstate red
set __fish_git_prompt_color_upstream_ahead yellow
set __fish_git_prompt_color_upstream_behind yellow

# Hide the parentheses
set __fish_git_prompt_color_prefix black
set __fish_git_prompt_color_suffix black

# Status symbols
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate ''
set __fish_git_prompt_char_untrackedfiles ''
set __fish_git_prompt_char_stashstate '^'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_diverged '↕'
