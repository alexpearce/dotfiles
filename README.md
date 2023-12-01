# Dotfiles

This is my collection of [configuration files](http://dotfiles.github.io/).

It uses [home-manager][home-manager]—a [Nix][nix]-based tool—to install
programs and create their configuration files based off the
[`home.nix`](home.nix) file in this repository. I [wrote more about it in a
blog post][nix-post].

(I used to [use GNU Stow][stow-post]. The last Stow-based commit was
[`4f1feee1e`][stow-commit].)

## Usage

Install [Nix][nix] with Nix Flake support enabled, for example by using the [Determinate Systems installer][nix-installer].
You should be able to run the `nix flake` command in a shell.

Next, clone this repository. We'll use `~/Code/dotfiles`.

```shell
$ git clone git@github.com:alexpearce/dotfiles.git ~/Code/dotfiles
```

The home-manager profile can then be built and activated:

```shell
$ nix run home-manager/master -- switch --flake ~/Code/dotfiles#apearwin
```

To update dependencies:

```shell
$ nix flake update ~/Code/dotfiles
```

### Fish

I like to set [fish][fish] as my default shell. On macOS this means:

1. Editing `/etc/shells` to include an entry for the home-manager-managed
   `fish` binary at `~/.nix-profile/bin/fish`.
2. Setting the default shell with `chsh -s ~/.nix-profile/bin/fish`.

## License

[MIT](http://opensource.org/licenses/MIT).

[nix]: https://nixos.org/
[nix-installer]: https://github.com/DeterminateSystems/nix-installer
[home-manager]: https://github.com/nix-community/home-manager
[fish]: https://fishshell.com/

[nix-post]: https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
[stow-post]: https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
[stow-commit]: https://github.com/alexpearce/dotfiles/tree/4f1feee1e4bc71f2ba5774af44eed1da774510a0
