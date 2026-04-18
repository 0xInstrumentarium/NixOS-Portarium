{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    nixosConfigurations = {
    portarium = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
        modules = [ 
          { 
            nix.settings.experimental-features = ["nix-command" "flakes"]; 
          }
        ./configuration.nix
        ];
      };
    };
  };
