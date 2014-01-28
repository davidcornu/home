#!/usr/bin/env bash

set -e

log(){ 
  echo -e "$(tput setaf 2)> $*$(tput sgr0)" 
}

warn(){ 
  echo -e "$(tput setaf 1)> $*$(tput sgr0)" 
}

header(){
  echo
  echo -e "$(tput bold)$(tput setaf 6)### $* ###$(tput sgr0)"
  echo
}

ensure_symlink(){
  local source=$1
  local destination=$2

  if [ -h "$destination" ]
  then
    log "$destination is already symlinked"
  else
    log "Symlinking $source to $destination"
    ln -s "$source" "$destination"
  fi
}

ensure_directory(){
  local dir_path=$1

  if [ -d "$dir_path" ]
  then
    log "$dir_path already exists"
  else
    log "$dir_path does not exist. Creating."
    mkdir -p $dir_path
  fi
}

ensure_repo(){ 
  local repo_path=$1
  local repo_url=$2
  
  ensure_directory $repo_path
  
  (
    cd "$repo_path"
    if git rev-parse --is-inside-work-tree > /dev/null
    then
      log "$repo_path is a already a git repository. Updating."
      git pull origin master
    else
      log "$repo_path isn't a git repository. Creating."
      git clone "$repo_url" "$repo_path"
    fi
  )
}

header "Setting up config files"

# Config files

ensure_symlink ~/dotfiles/vimrc ~/.vimrc
ensure_symlink ~/dotfiles/zshrc ~/.zshrc
ensure_symlink ~/dotfiles/gitconfig ~/.gitconfig
ensure_symlink ~/dotfiles/gitignore ~/.gitignore
ensure_symlink ~/dotfiles/gemrc ~/.gemrc
ensure_symlink ~/dotfiles/tmux.conf ~/.tmux.conf

header "Setting up packages"

# Shell

ensure_repo ~/.oh-my-zsh git@github.com:robbyrussell/oh-my-zsh.git
ensure_repo ~/.oh-my-zsh/custom/plugins/pure git@github.com:sindresorhus/pure.git
ensure_repo ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting git@github.com:zsh-users/zsh-syntax-highlighting.git 

# Vim

ensure_repo ~/.vim/bundle/vundle git@github.com:gmarik/vundle.git

# Ruby

ensure_repo ~/.rbenv git@github.com:sstephenson/rbenv.git
ensure_repo ~/.rbenv/plugins/ruby-build git@github.com:sstephenson/ruby-build.git

# Node

ensure_repo ~/.nvm git@github.com:creationix/nvm.git
