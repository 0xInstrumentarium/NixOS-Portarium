{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = inputs@{ nixpkgs, home-manager, niri, ... }: {
    nixosConfigurations.portarium = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
        ./configuration.nix
        # Add the niri nixos overlay so pkgs.niri comes from the flake
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.james = import ./home.nix;
        }
      ];
    };
  };
}
