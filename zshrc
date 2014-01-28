export PATH=""

# Load default OS X PATH
if [ -x /usr/libexec/path_helper ]; then eval `/usr/libexec/path_helper -s`; fi

# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh
plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Pure theme
source ~ZSH_CUSTOM/plugins/pure/pure.zsh

# For local customizations
if [ -f ~/.profile ] || [ -h ~/.profile ]; then source ~/.profile; fi

# Mac-specifics
if [ "$(uname -s)" = "Darwin" ]
then
  # Rebuild the Launch Services database
  # (Gets rid of duplicates in the "Open With" submenu)
  alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

  # Aliases
  alias mou='open -a mou'
  alias subl='open -a "Sublime Text"'
  alias marked='open -a "Marked"'
  alias gitbox='open -a "Gitbox"'

  # Add Homebrew to PATH
  if [ -d "/usr/local/Cellar" ]
  then
    PATH="/usr/local/bin:$PATH"
  fi

  # Add Postgres.app to PATH
  if [ -d /Applications/Postgres.app ]
  then
    PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  fi
fi

# Git commands
alias delete-local-branch='git branch -D'
alias delete-remote-branch='git push origin --delete'
alias cleanup-remote-branches='git remote prune origin'

# Misc
alias serve='python -m SimpleHTTPServer'
alias venv='source ./virtualenv/bin/activate'

# Get rid of autocorrection
unsetopt correct_all

# Load rbenv
if [ -d ~/.rbenv ]
then
  PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# Load nvm
if [ -d ~/.nvm ]
then
  source ~/.nvm/nvm.sh
fi

# Set editor
if which vim > /dev/null
then
  export EDITOR="$(which vim)"
else
  echo "Could not find vim"
fi
