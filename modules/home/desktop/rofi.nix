
{self, inputs, ...}:
{
  flake.homeModules.rofi = {pkgs, lib, ...}: {
  
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      font = "Fira Code";
      modes = [
        "drun"
        "emoji"
        "ssh"
      ];
      plugins = [
        pkgs.rofi-calc
        pkgs.rofi-nerdy
        pkgs.rofi-systemd
        pkgs.rofi-bluetooth
        pkgs.rofi-power-menu
        pkgs.rofi-network-manager
      ];

      terminal = "ghostty";

      yoffset = 0;
    };
  };
}
