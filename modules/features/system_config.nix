{ self, inputs, ... }: {

  flake.nixosModules.systemConfig = { pkgs, lib, ... }: {

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

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    xdg.portal = {
     enable = true;
     extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
     config.niri.default = [ "gtk" ];
    };

    programs.dconf.enable = true;
    # Required for your home-manager bash configurations to work cleanly
    system.stateVersion = "26.05";

  };
}
