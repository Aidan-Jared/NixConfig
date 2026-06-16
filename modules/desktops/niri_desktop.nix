{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.desktopManager.gnome.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "niri";

  programs.xwayland.enable = true;

  programs.niri = {
    enable = true;
    # 
    # withUWSM = true;
#    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
#    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
   };
services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet} --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd = {
    # This forces systemd to wait until graphical drivers are active
    wants = [ "display-manager.service" ];
    after = [ "display-manager.service" ];
    
    serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
