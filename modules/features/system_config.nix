{ self, inputs, ... }: {

  flake.nixosModules.systemConfig = { pkgs, lib, ... }: {

    time.timeZone = "Pacific/Auckland";

    i18n.defaultLocale = "en_NZ.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_NZ.UTF-8";
      LC_IDENTIFICATION = "en_NZ.UTF-8";
      LC_MEASUREMENT = "en_NZ.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_NZ.UTF-8";
      LC_NUMERIC = "en_NZ.UTF-8";
      LC_PAPER = "en_NZ.UTF-8";
      LC_TELEPHONE = "en_NZ.UTF-8";
      LC_TIME = "en_NZ.UTF-8";
    };

    environment.systemPackages = [ pkgs.polkit_gnome ];

    security.polkit.enable = true;
    services.upower.enable = true;
    services.gnome.gnome-keyring.enable = true;

    xdg.portal = {
     enable = true;
     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
     config.niri.default = lib.mkForce [ "gtk" ];
    };

    programs.dconf.enable = true;

    system.stateVersion = "26.05";

  };
}
