{ lib, config, pkgs, ... }:
let
  apps = import ./applications.nix { inherit pkgs; };
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "super+Control+Return".action = spawn ["qs" "ipc" "call" "globalIPC" "toggleLauncher"];
    "xf86audioraisevolume".action = spawn pactl [ "set-sink-volume" "@DEFAULT_SINK@" "+5%" ];
    "xf86audiolowervolume".action = spawn pactl [ "set-sink-volume" "@DEFAULT_SINK@" "-5%" ];
    "control+super+xf86audioraisevolume".action = spawn "brightness" "up";
    "control+super+xf86audiolowervolume".action = spawn "brightness" "down";
    "super+q".action = close-window;
    "super+b".action = spawn apps.browser;
    "super+Return".action = spawn apps.terminal;
    "super+E".action = spawn apps.fileManager;
    "super+f".action = fullscreen-window;
    "super+t".action = toggle-window-floating;
    "super+Left".action = focus-column-left;
    "super+Right".action = focus-column-right;
    "super+Down".action = focus-workspace-down;
    "super+Up".action = focus-workspace-up;
    "super+Shift+Left".action = move-column-left;
    "super+Shift+Right".action = move-column-right;
    "super+Shift+Down".action = move-column-to-workspace-down;
    "super+Shift+Up".action = move-column-to-workspace-up;
    "super+1".action = focus-workspace "browser";
    "super+2".action = focus-workspace "vesktop";
  };
}