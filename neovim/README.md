# Neovim configuration

To set up, install [vim-plug][vim-plug] and then install the plugins.

    $ curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    $ nvim +PlugInstall +qa

Dictionaries
------------

To setup dictionaries for Neovim that support unicode quotes (e.g. `you’re` 
rather than `you're`), download the `en_US` and `en_GB-large` dictionaries from 
[SCOWL](http://wordlist.aspell.net/dicts/), and then install them:

```
$ mkdir -p ~/.local/share/nvim/site/spell
$ cp en_GB-large.aff ~/.local/share/nvim/site/spell/en_GB.aff
$ cp en_GB-large.dic ~/.local/share/nvim/site/spell/en_GB.dic
$ cp en_US.* ~/.local/share/nvim/site/spell/
```

Then open Neovim in the `spell` directory and execute `:mkspell! en en_US 
en_GB` to build the Neovim dictionaries.

[vim-plug]: https://github.com/junegunn/vim-plug
