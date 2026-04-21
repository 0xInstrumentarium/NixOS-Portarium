# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ inputs, config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-8333a14b-c1ca-4aff-b0e9-99d8c25f6605".device = "/dev/disk/by-uuid/8333a14b-c1ca-4aff-b0e9-99d8c25f6605";

  networking.hostName = "portarium";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT    = "de_DE.UTF-8";
    LC_MONETARY       = "de_DE.UTF-8";
    LC_NAME           = "de_DE.UTF-8";
    LC_NUMERIC        = "de_DE.UTF-8";
    LC_PAPER          = "de_DE.UTF-8";
    LC_TELEPHONE      = "de_DE.UTF-8";
    LC_TIME           = "de_DE.UTF-8";
  };

  # X11 is still needed as a base even with Wayland/niri
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };
  console.keyMap = "no";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.james = {
    isNormalUser = true;
    description = "james";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [];
  };

  security.sudo.extraRules = [
    {
      users = [ "james" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  nixpkgs.config.allowUnfree = true;

  # XDG portal — required for niri/wayland screensharing, file pickers etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    zsh
    home-manager
    quickshell
    fastfetch
    ffmpeg
    obsidian
    p7zip
    killall
    btop
    mpv
    vesktop
    mpvpaper
    neovim
    libreoffice-qt
    power-profiles-daemon
    jdk8
    anki-bin
    spotify
    qbittorrent
    vivaldi
    mullvad-vpn
    eclipses.eclipse-cpp
    ghostty
    keepassxc
    thunderbird
    kdePackages.dolphin
    wmctrl
    yq-go
    xclip
    matugen
    eww
    swappy
    slurp
    grim
    playerctl
    satty
    kdePackages.okular
    zenity
    fzf
    direnv
    zbar
    taskwarrior3
    inotify-tools
    kdePackages.sddm
    plymouth
    ddcutil
    wl-clipboard        # needed by your niri screenshot binds
    xwayland-satellite  # for xwayland support under niri
    cava
    swayosd
    bat
    rofi
    kitty
  ];
  programs.niri.enable = true;
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  boot = {
    plymouth = {
      enable = true;
      theme = "simple";
      themePackages = [
        (pkgs.stdenv.mkDerivation {
          pname = "plymouth-theme-simple";
          version = "1.0";
          src = ./config/programs/plymouth/simple;
          installPhase = ''
            mkdir -p $out/share/plymouth/themes/simple
            cp -r * $out/share/plymouth/themes/simple/
            substituteInPlace $out/share/plymouth/themes/simple/simple.plymouth \
              --replace "@out@" "$out"
          '';
        })
      ];
    };

    consoleLogLevel = 0;
    initrd.verbose = false;

  };

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
