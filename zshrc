export PATH=""

# Load default PATH
if [ -x /usr/libexec/path_helper ]; then eval "$(/usr/libexec/path_helper -s)"; fi
if [ -f /etc/environment ]; then source /etc/environment; fi

# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh
plugins=(zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Pure theme
source ~ZSH_CUSTOM/plugins/pure/async.zsh
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
  alias marked='open -a "Marked 2"'
  alias gitbox='open -a "Gitbox"'

  # Add Homebrew to PATH
  if [ -d "/usr/local/Cellar" ]
  then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  fi

  # Add Postgres.app to PATH
  if [ -d /Applications/Postgres.app ]
  then
    PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
  fi
fi

# Add Cargo binaries to PATH
PATH="$HOME/.cargo/bin:$PATH"

# Add Yarn binaries to PATH
PATH="$HOME/.yarn/bin:$PATH"

# Add Go
if [ -d "$HOME/Development/Go" ]
then
  export GOPATH="$HOME/Development/Go"
  PATH="$GOPATH/bin:$PATH"
fi

# Git commands
alias gitroot='cd "$(git rev-parse --show-toplevel)"'
function strip-diff {
  (
    set -e
    cd "$(git rev-parse --show-toplevel)"
    git diff-files --name-only -0 | while read line; do
      target="/tmp/$(git hash-object -- $line)-stripped"
      git stripspace < "$line" > "$target"
      cat "$target" > "$line"
      rm "$target"
    done
  )
}

# Simpler Bundler
function b {
  { bundle check > /dev/null || bundle install; } && bundle exec $*
}

# Misc
alias serve='ruby -run -e httpd . -p 9090'
alias venv='source ./virtualenv/bin/activate'
alias runtest='b ruby -I ./test'
alias volmer='b rubocop $(git diff-files --name-only -0)'
alias irb='irb -r "irb/completion"'
alias wat='TDD=0 SKIP_BOOTSTRAP=1 PRY=1 DONT_HELP_MY_COWORKERS_MAKE_EVIDENCE_BASED_DECISIONS=1 DISABLE_SPRING=1 DISABLE_PEEK=1'
alias clear-elasticsearch='curl -X DELETE "http://localhost:9200/*/"'
alias kill-railgun='railgun status -a | tail -n +2 | cut -d " " -f1 | xargs -n 1 railgun stop'
alias vim='nvim'
alias clear-yarn="ruby -r json -r fileutils -e \"JSON.parse(File.read('config/npm_packages.json')).each { |dir| FileUtils.rm_rf(dir + '/node_modules') }\" && yarn cache clean"

function inspect-cert {
  openssl x509 -noout -text -in $1
}

function inspect-csr {
  openssl req -noout -text -in $1
}

# Get rid of autocorrection
unsetopt correct_all

function load-rbenv {
  if [ -d ~/.rbenv ]
  then
    export PATH=~/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
  fi
}

function load-nvm {
  if [ -s ~/.nvm/nvm.sh ]
  then
    source ~/.nvm/nvm.sh
  fi
}

if [ -f /opt/dev/dev.sh ]
then
  source /opt/dev/dev.sh
else
  load-rbenv
  load-nvm
fi

# Set editor
export EDITOR=nvim

# Use FZF if it's around
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
