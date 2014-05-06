Dotfiles
========

This is my collection of [configuration files](http://dotfiles.github.io/).

Usage
-----

Pull the repo along with all it's submodules

```bash
git clone --recursive git@github.com:alexpearce/dotfiles.git $HOME/.dotfiles
```

Deploy!

```bash
cd ~/.dotfiles
rake install
```

There are two terminfo files in the `terminfo` directory.
These are for [enabling italics in iTerm2, vim, and tmux](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/).
Currently they are not added automatically.

License
-------

[MIT](http://opensource.org/licenses/MIT).
