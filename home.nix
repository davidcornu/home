{ pkgs, ... }: {
  home.username = "david";
  home.homeDirectory = "/Users/david";
  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.atuin
    pkgs.bat
    pkgs.datasette
    pkgs.difftastic
    pkgs.exa
    pkgs.fzf
    pkgs.git
    pkgs.jq
    pkgs.mtr
    pkgs.neovim
    pkgs.ripgrep
    pkgs.rnix-lsp
    pkgs.shellcheck
    pkgs.sqlite-interactive
    pkgs.watchexec
    pkgs.youtube-dl
    pkgs.vscodium
    pkgs.fish
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
