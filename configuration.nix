{ config, pkgs, inputs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/general.nix
    ./modules/users.nix
    ./modules/networking.nix
    ./modules/nvidia.nix
    ./modules/security.nix
    # ./modules/desktops/desktop.nix
    # ./modules/desktops/hyprland_desktop.nix
    ./modules/desktops/niri_desktop.nix
    #./modules/desktops/stylix.nix
    ./modules/system_packages.nix
    ./modules/fonts.nix
    ./modules/nix_settings.nix
    ./modules/environment_var.nix
  ];

  time.timeZone = "Pacific/Auckland";

  i18n.defaultLocale = "en_NZ.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  # Required for your home-manager bash configurations to work cleanly
  system.stateVersion = "26.05";

  networking.networkmanager.enable = true;
}
