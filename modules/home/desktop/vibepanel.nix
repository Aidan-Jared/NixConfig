{ inputs, ... }: {
  flake.homeModules.vibepanel = { pkgs, lib, ... }: {
    home.packages = [
      inputs.vibepanel.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    xdg.configFile."vibepanel/config.toml".text = lib.generators.toTOML {} {
      bar.size = 32;
      widgets = {
        left = [ "workspaces" "window_title" ];
        center = [ "media" ];
        right = [ "quick_settings" "battery" "clock" "notifications" ];
      };
      theme = {
        mode = "dark";
        accent = "#adabe0";
      };
    };
  };
}
