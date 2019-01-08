# Sway configuration

[Sway][sway] is an [i3][i3]-compatible window manager. The configuration files
in this folder are for sway and a few associated utilities that I use alongside
it:

* [waybar][waybar]: a topbar that displays the list of workspaces and other information,
  such as network status and datetime.
* [mako][mako]: notification display.
* swaylock: screen locking.
* swaynag: message dialogs.

If you want to use [tmux][tmux] with sway, you might also be interested in the
custom [`refresh_tmux_environment` fish shell function][refresher]

## Dependencies

The following are required for running my setup, all installed from the AUR:

* wlroots-git
* sway-git
* mako-git
* waybar-git
* [grim-git][grim] (for screenshots)
* [slurp-git][slurp] (for selecting screen areas for grim)

These programs are used in the configuration files, though aren’t necessary for
getting everything up and running:

* [kitty][kitty] (terminal emulator)
* firefox (browser)
* [ttf-inter-ui][interui] (UI font)
* [otf-font-awesome][fontawesome] (for icons in waybar, using this rather than `ttf-` version
  because of https://github.com/Anachron/i3blocks/issues/53)

[sway]: https://swaywm.org/
[i3]: https://i3wm.org/
[waybar]: https://github.com/Alexays/Waybar
[mako]: https://github.com/emersion/mako
[tmux]: https://github.com/tmux/tmux/wiki
[refresher]: ../fish/.config/fish/functions/refresh_tmux_environment.fish
[grim]: https://github.com/emersion/grim
[slurp]: https://github.com/emersion/slurp
[kitty]: https://sw.kovidgoyal.net/kitty/
[interui]: https://rsms.me/inter/
[fontawesome]: https://fontawesome.com/
