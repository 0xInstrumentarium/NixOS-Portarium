# config/programs/niri/default.nix
{ inputs, pkgs, ... }:
{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./rules.nix
    ./autostart.nix
    ./scripts.nix
  ];
}
