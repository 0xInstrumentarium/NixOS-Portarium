{ lib, pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
  #  { command = ["systemctl" "--user" "start" "hyprpolkitagent"]; }
  #  { command = ["arrpc"]; } #discord rpc
    { command = ["xwayland-satellite"]; }
    { command = ["qs"]; }
    { command = ["vesktop"]; }
    { command = ["mpvpaper"]; }
  # { command = ["swww-daemon"]; }
  # { command = ["${pkgs.swaybg}/bin/swaybg" "-o" "DP-1" "-i" "/home/lysec/nixos/assets/wallpapers/clouds.png" "-m" "fill"]; }
  # { command = ["sh" "-c" "swww-daemon & swww img /home/lysec/nixos/wallpapers/cloud.png"]; }
  ];
}
