{ config, pkgs, inputs, ... }:
{
  home.username = "james";
  home.homeDirectory = "/home/james";
  home.stateVersion = "25.11";

  imports = [
    # niri-flake's home-manager config module (provides programs.niri.settings)
    # Your niri config folder
    ./config/niri/default.nix
    ./config/niri/default.nix
    ./config/programs/cava/default.nix
    ./config/programs/firefox/default.nix
    ./config/programs/matugen/default.nix
    ./config/programs/neovim/default.nix
    ./config/programs/swayosd/default.nix
    ./config/programs/zsh/default.nix

  ];

  home.packages = [];
  home.file = {};
  home.sessionVariables = {};

  programs.home-manager.enable = true;
}
