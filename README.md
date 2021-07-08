# Dotfiles

This is my collection of [configuration files](http://dotfiles.github.io/).

## Usage

Pull the repository, and then create the symbolic links [using GNU
stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).

```shell
$ git clone git@github.com:alexpearce/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow fish neovim git # plus whatever else you'd like
```

## Dependencies

The [fish shell][fish] configuration uses [Starship][starship] to generate a
prompt. A few tools are optional but make the experience nicer:

* [bat][bat] for output.
* [exa][exa] for listings.
* [ripgrep][ripgrep] for file searching.

I install [Conda][conda], specifically [Mambaforge][mambaforge], to manage
Python environments. Conda is picked up automatically by the shell if the
install path is set to `$HOME/.local/conda`.

### Neovim

The [Neovim editor][neovim] (>= 0.5) configuration assumes there is a dedicated
virtual environment for it at `$HOME/.local/conda/envs/neovim`.

```shell
$ conda create --name neovim pynvim
```

Neovim packages are managed using [packer.nvim][packer]. Run `:PackerCompile`
followed by `:PackerInstall` to install.

The [language server configuration][lsp] requires the relevant servers to be
installed:

```shell
# Python
$ npm install -g pyright
# Rust
$ brew install rust-analyzer
# C family (using clangd)
$ brew install llvm
```

## License

[MIT](http://opensource.org/licenses/MIT).

[fish]: https://fishshell.com/
[starship]: https://starship.rs/
[neovim]: https://neovim.io/
[conda]: https://conda.io/
[mambaforge]: https://github.com/conda-forge/miniforge
[bat]: https://github.com/sharkdp/bat
[exa]: https://github.com/ogham/exa
[ripgrep]: https://github.com/BurntSushi/ripgrep
[packer]: https://github.com/wbthomason/packer.nvim
[lsp]: https://github.com/neovim/nvim-lspconfig
