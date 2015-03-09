export PATH=""

# Load default PATH
if [ -x /usr/libexec/path_helper ]; then eval "$(/usr/libexec/path_helper -s)"; fi
if [ -f /etc/environment ]; then source /etc/environment; fi

# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh
plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Pure theme
source ~ZSH_CUSTOM/plugins/pure/pure.zsh
PURE_GIT_PULL=0

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
alias cleanup-local-branches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias vim-conflicts='vim $(git diff-files --name-only -0)'

function strip-diff {
  (
    set -e
    git diff-files --name-only -0 | while read line; do
      target=$(tempfile)
      git stripspace < "$line" > "$target"
      cat "$target" > "$line"
      rm "$target"
    done
  )
}

# Misc
alias serve='ruby -run -e httpd . -p 9090'
alias venv='source ./virtualenv/bin/activate'
alias b='(bundle check || bundle install) && bundle exec'
alias s='b spring'
alias runtest='b ruby -I ./test'
alias irb='irb -r "irb/completion"'
alias wat='TDD=0 DEBUG=1 SKIP_BOOTSTRAP=1'
alias clear-elasticsearch='curl -X DELETE "http://localhost:9200/*/"'

# Get rid of autocorrection
unsetopt correct_all

# Load rbenv
if [ -d ~/.rbenv ]
then
  PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# Load nvm
if [ -s ~/.nvm/nvm.sh ]
then
  source ~/.nvm/nvm.sh
fi

# Set editor
export EDITOR=vim

# Quick Vagrant
function v { (
  cd ~/vagrant && vagrant $* )
}

function dev {
  (
    set -e
    cd ~/vagrant
    if vagrant status | grep -q 'powered off'; then vagrant up; fi
    vagrant ssh -- -t 'cd ~/src/shopify; exec $SHELL --login'
  )
}
