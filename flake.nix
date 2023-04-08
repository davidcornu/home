{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=a1240f6b4a0bcc84fc48008b396a140d9f3638f6";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    }: flake-utils.lib.eachDefaultSystem (system:
    {
      defaultPackage = home-manager.defaultPackage.${system};

      packages.homeConfigurations."david@medina" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix ];
      };
    }
    );
}
