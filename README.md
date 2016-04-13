Dotfiles
========

This is my collection of [configuration files](http://dotfiles.github.io/).

Usage
-----

Pull the repository, and then create the symbolic links [using GNU
stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).

```bash
$ git clone git@github.com:alexpearce/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow fish vim tmux # plus whatever else you'd like
```

The `fish` dotfiles depend on [the fish shell](http://fishshell.com),
so install that first:

```bash
$ brew install fish
# Add /usr/local/bin/fish to /etc/shells, then do
$ chsh -s /usr/local/bin/fish
```

The Vim dotfiles depend on [vim-plug](https://github.com/junegunn/vim-plug) for 
installing Vim plugins:

```bash
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ vim +PlugInstall +qa
```

There's a [gruvbox][gruvbox] colourscheme for iTerm2 called 
[`gruvbox.itermcolors`](gruvbox.itermcolors).

License
-------

[MIT](http://opensource.org/licenses/MIT).

[gruvbox]: https://github.com/morhetz/gruvbox
