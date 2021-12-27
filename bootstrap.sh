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
    mkdir -p "$dir_path"
  fi
}

ensure_repo(){
  local repo_path=$1
  local repo_url=$2

  ensure_directory "$repo_path"

  (
    cd "$repo_path"
    if git rev-parse --is-inside-work-tree > /dev/null && [ "$repo_path" =  "$(git rev-parse --show-toplevel)" ]
    then
      log "$repo_path is a already a git repository. Updating."
      git pull origin $(git rev-parse --abbrev-ref HEAD)
    else
      log "$repo_path isn't a git repository. Creating."
      git clone "$repo_url" "$repo_path"
    fi
  )
}

if [ "$(uname -s)" = "Darwin" ]; then
  is_mac=1
fi

header "Setting up config files"

# Config files
# ensure_symlink ~/dotfiles/vimrc ~/.vimrc
ensure_directory ~/.config/nvim
ensure_symlink ~/dotfiles/nvimrc ~/.config/nvim/init.vim
ensure_symlink ~/dotfiles/ideavimrc ~/.ideavimrc
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
# ensure_repo ~/.vim/bundle/Vundle.vim git@github.com:VundleVim/Vundle.vim.git

# if [ -x "$(command -v vim)" ]; then
#   header "Installing Vim plugins"
#   vim -s ~/dotfiles/install_plugins.vim
# else
#   header "Skipping Vim extensions"
# fi

# NeoVim
ensure_repo ~/.config/nvim/bundle/Vundle.vim git@github.com:VundleVim/Vundle.vim.git

if [ -x "$(command -v nvim)" ]; then
  header "Installing NeoVim plugins"
  nvim -s ~/dotfiles/install_plugins.vim
else
  header "Skipping NeoVim extensions"
fi

# Ruby
ensure_repo ~/.rbenv git@github.com:sstephenson/rbenv.git
ensure_repo ~/.rbenv/plugins/ruby-build git@github.com:sstephenson/ruby-build.git

# Node
ensure_repo ~/.nvm git@github.com:creationix/nvm.git

# VSCode
if [ -x "$(command -v code)" ]; then
  if [ -n "$is_mac" ]; then
    header "Symlinking VSCode config files"
    ensure_symlink ~/dotfiles/vscode.json ~/Library/Application\ Support/Code/User/settings.json
    ensure_symlink ~/dotfiles/vscode-keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
  fi

#   header "Checking VSCode extensions"
# 
#   missing=$(comm -1 -3 <(code --list-extensions | sort) <(sort ~/dotfiles/vscode-extensions.txt))
# 
#   if [ -n "$missing" ]; then
#     log "The following packages are not installed"
#     echo $missing
#     log "Installing"
#     echo "$missing" | xargs -n 1 code --install-extension
#   else
#     log "All VSCode extensions are installeds"
#   fi
# 
#   header "Saving installed extensions"
#   code --list-extensions | sort > ~/dotfiles/vscode-extensions.txt
#   log "Done."
# else
#   header "Skipping VSCode extensions"
# fi

# Homebrew
if [ -x "$(command -v brew)" ]; then
  header "Checking for recommended Homebrew packages"

  missing=$(comm -1 -3 <(brew list --full-name | sort) <(sort ~/dotfiles/brew-packages.txt))

  if [ -n "$missing" ]; then
    log "The following packages are not installed"
    echo "$missing"
    log "Installing"
    echo "$missing" | xargs -n 1 brew install
  else
    log "All recommended Homebrew packages installed"
  fi
else
  header "Skipping Homebrew"
fi
