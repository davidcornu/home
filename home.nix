{ pkgs, ... }: {
  home.username = "david";
  home.homeDirectory = "/Users/david";
  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    atuin
    bat
    datasette
    difftastic
    dive
    git
    jq
    mosh
    mtr
    neovim
    nixpkgs-fmt
    ripgrep
    sfz
    shellcheck
    sqlite-interactive
    tmux
    watchexec
    hurl
    flyctl
    lima
    graphicsmagick
    nixd
    btop
    overmind
    hexyl
    nil
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file = {
    ".gemrc".source = ./dotfiles/gemrc;
    ".gitconfig".source = ./dotfiles/gitconfig;
    ".gitignore".source = ./dotfiles/gitignore;
    ".ideavimrc".source = ./dotfiles/ideavimrc;
    ".tmux.conf".source = ./dotfiles/tmux.conf;
    ".config/nvim/init.lua".source = ./dotfiles/neovim.lua;
    ".config/fish/config.fish".source = ./dotfiles/config.fish;
    ".config/fish/nightfox.fish".source = ./dotfiles/nightfox.fish;
    ".cargo/config.toml".source = ./dotfiles/cargo.toml;
    ".sqliterc".source = ./dotfiles/sqliterc;
  };
}
