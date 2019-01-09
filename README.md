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
$ stow fish neovim tmux # plus whatever else you'd like
```

License
-------

[MIT](http://opensource.org/licenses/MIT).
