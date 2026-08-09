{ inputs, ... }: {
  flake.homeModules.vibepanel = { pkgs, lib, ... }: {
    home.packages = [
      inputs.vibepanel.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    xdg.configFile."vibepanel/config.toml".text = lib.generators.toTOML {} {
      widgets = {
        left = [ "workspaces" "window_title" ];
        center = [ "clock" ];
        right = [ "quick_settings" "battery" "cpu" "memory" "gpu" "notifications" ];
        clock = {
          show_weather = true;
        };
        quick_settings = {};
      };
      theme = {
        mode = "dark";
        accent = "#adabe0";
      };
      bar = {
        position = "top";
        size = 32;
      };
    };

  };
}
