# config/programs/niri/default.nix
{ inputs, pkgs, ... }:
{
  imports = [
    ./settings.nix
    ./binds.nix
    ./rules.nix
    ./autostart.nix
    ./scripts.nix
  ];
}
