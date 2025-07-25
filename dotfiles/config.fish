# Commands to run in interactive sessions can go here
if status is-interactive
  if type -q atuin
    atuin init fish | source
  end
end

# Add Cargo binaries to PATH
fish_add_path -a "$HOME/.cargo/bin"

# Add Yarn binaries to PATH
fish_add_path "$HOME/.yarn/bin"

# Add Postgres.app to PATH
if test -d "/Applications/Postgres.app"
  fish_add_path "/Applications/Postgres.app/Contents/Versions/latest/bin"
end

# Add Homebrew to PATH
fish_add_path /opt/homebrew/bin

# Add Nix profile to PATH
fish_add_path "/nix/var/nix/profiles/default/bin"
fish_add_path "$HOME/.nix-profile/bin"

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# Turn off greeting message
set -U fish_greeting

# Set nightfox color scheme
source ~/.config/fish/nightfox.fish

# Use nvim instead of vim if available
if type -q nvim
  alias vim="nvim"
  set EDITOR "nvim"
else
  set EDITOR "vim"
end

if type -q direnv
  direnv hook fish | source
end

if type -q jj
  jj util completion fish | source
end

if test -d "/Applications/1Password.app"
  set SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
end
