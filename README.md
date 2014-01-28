# Dotfiles

## Installation

```shell
$ cd ~/
$ git clone git@github.com:davidcornu/dotfiles.git
$ ./dotfiles/bootstrap.sh
```

The boostrap script will symlink config files from `~/dotfiles` into `~/` and install the following packages:

- https://github.com/robbyrussell/oh-my-zsh
- https://github.com/sindresorhus/pure
- https://github.com/zsh-users/zsh-syntax-highlighting
- https://github.com/gmarik/vundle
- https://github.com/sstephenson/rbenv
- https://github.com/sstephenson/ruby-build
- https://github.com/creationix/nvm

## Updating

```shell
$ cd ~/dotfiles
$ git pull
$ ./bootstrap.sh
```
