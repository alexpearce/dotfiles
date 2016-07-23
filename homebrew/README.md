Homebrew
========

Lists of formulae and casks that I install on my OS X machine using 
[Homebrew][homebrew] and [Homebrew Casks][homebrew-casks].

To install:

```shell
$ tr '\n' '\0' < formulae | xargs -0 brew install
$ tr '\n' '\0' < casks | xargs -0 brew cask install
```

[homebrew]: http://brew.sh
[homebrew-casks]: https://caskroom.github.io/
