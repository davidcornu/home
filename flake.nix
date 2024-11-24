{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jujutsu = {
      url = "github:martinvonz/jj/v0.23.0";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    , jujutsu
    }: flake-utils.lib.eachDefaultSystem (system:
    {
      defaultPackage = home-manager.defaultPackage.${system};

      packages.homeConfigurations."david@tycho" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          {
            home.packages = [ jujutsu.packages.${system}.default ];
          }

          ./home.nix
        ];
      };
    }
    );
}
