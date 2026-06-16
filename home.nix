{ config, lib, ... }:
{
  home.username = "samantha";
  home.homeDirectory = lib.mkForce "/home/samantha";
  home.stateVersion = "26.05";
  
  imports = [
    ./home/shell.nix
    # ./home/terminal/cosmic.nix
    ./home/terminal/ghostty.nix
    # ./home/desktops/hyprland.nix
    ./home/desktops/niri.nix
    ./home/dev.nix
    ./home/dotfiles/dotfiles.nix
    ./home/comunication.nix
    ./home/editors.nix
    ./home/browsers/zen.nix
    ./home/cli_tools.nix
  ];
}
