{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations.portarium = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }

        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.james = import ./home.nix;
        }
      ];
    };
  };
}