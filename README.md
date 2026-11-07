# Dotfiles

Configuration for my personal machines, using [Nix][nix].
I [wrote about the early days in a blog post][nix-post].

| Host | What | Platform | Apply with |
|------|------|----------|------------|
| `pearwin-laptop` | Personal MacBook | aarch64-darwin | `darwin-rebuild` |
| `kazooie` | Asus ROG Xbox Ally X | x86_64-linux | `colmena apply` |

Standalone Home Manager profiles are also available: `apearwin` for macOS and `apearwin-ci` for the Linux CI runner.

## Layout

The flake follows the [dendritic pattern][dendritic].
Every `.nix` file under `modules/` is a [flake-parts][flake-parts] module, loaded automatically by [import-tree][import-tree].
Paths containing `/_` are skipped; this is where plain NixOS modules and package definitions belong.

A feature defines modules for the classes it needs, by name:

```nix
# modules/programs/fish.nix
{
  flake.modules.homeManager.fish.programs.fish.enable = true;
  flake.modules.darwin.fish.programs.fish.enable = true;
}
```

Home Manager features are automatically available under the same name to NixOS and nix-darwin hosts through
[`home-manager-aspects.nix`](modules/flake/home-manager-aspects.nix).
Hosts import the `home-manager` feature and list the other features they need:

```nix
# modules/hosts/pearwin-laptop.nix
{ config, ... }:
{
  hosts.pearwin-laptop.system = "aarch64-darwin";
  flake.modules.darwin.pearwin-laptop = {
    imports = with config.flake.modules.darwin; [ home-manager macos fish git ];
    # Other host settings go here.
  };
}
```

[`hosts.nix`](modules/flake/hosts.nix) turns each `hosts.<name>` declaration into a system configuration, a check, and (for NixOS) a Colmena node.
[`personal.nix`](modules/homes/personal.nix) composes the same Home Manager features for the standalone profiles.
macOS-specific user configuration lives in the Home Manager features too, so standalone profiles retain it.

## Usage

Install Nix with flake support, for example using the [Determinate Systems installer][nix-installer], and clone this repository.
`nix develop` provides Colmena and agenix.

### macOS

For a system managed by nix-darwin, the first activation is:

```shell
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#pearwin-laptop
```

Afterwards:

```shell
sudo darwin-rebuild switch --flake .#pearwin-laptop
```

Alternatively, use Home Manager alone:

```shell
nix run home-manager/master -- switch --flake .#apearwin
```

Tell Hammerspoon where its configuration lives:

```shell
defaults write org.hammerspoon.Hammerspoon MJConfigFile "${XDG_CONFIG_HOME:-$HOME/.config}/hammerspoon/init.lua"
```

### NixOS

```shell
colmena apply --on kazooie
```

The host builds on the target.
The standard `nixosConfigurations.kazooie` output remains available for `nixos-rebuild` and installation tools.

### Updates and checks

```shell
nix flake update
nix flake update nixpkgs-kazooie          # update only the handheld's package set
nix fmt -- --ci
nix flake check --all-systems --no-build
python3 -m unittest discover -s tests
```

`nixpkgs-ai` follows `nixpkgs` by default and supplies `pkgs.unstable` for features that need an independently overridable tool package set.

CI checks formatting, evaluates every system and standalone profile, runs the composition tests, and builds the Linux Home Manager activation package without activating it on the runner.

`scripts/drv-paths.sh` prints the checked derivations.
When refactoring, compare before and after with `scripts/drvdiff.py OLD.drv NEW.drv`.
Its reordering classification is a review aid, not proof of semantic equivalence.

### Secrets

Personal secrets are encrypted with [agenix][agenix] to the public keys listed in [`secrets/agenix-rules.nix`](secrets/agenix-rules.nix):

```shell
cd secrets && RULES=agenix-rules.nix agenix -e <name>.age
```

### Fish

To use Nix-managed fish as the macOS login shell, add its path to `/etc/shells` and run `chsh -s <path>`.
With nix-darwin the path is `/run/current-system/sw/bin/fish`; with standalone Home Manager it is `~/.nix-profile/bin/fish`.

[agenix]: https://github.com/ryantm/agenix
[colmena]: https://github.com/zhaofengli/colmena
[dendritic]: https://github.com/mightyiam/dendritic
[flake-parts]: https://flake.parts
[home-manager]: https://github.com/nix-community/home-manager
[import-tree]: https://github.com/vic/import-tree
[nix-darwin]: https://github.com/LnL7/nix-darwin
[nix-installer]: https://github.com/DeterminateSystems/nix-installer
[nix]: https://nixos.org/
[nixos]: https://nixos.org/
[nix-post]: https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
