{ self, inputs, ... }: {
  flake.homeModules.ghostty = { pkgs, ... }: {
    home.packages = [ pkgs.ghostty ];
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        confirm-close-surface = false;
        font-size = 12;
        background-opacity = 0.9;
        window-padding-x = 8;
        window-padding-y = 8;
        cursor-style = "bar";
        shell-integration = "bash";
      };
    };
  };

  flake.homeModules.alacritty = { pkgs, ... }: {
    home.packages = [ pkgs.alacritty ];
    programs.alacritty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        confirm-close-surface = false;
        font-size = 12;
        background-opacity = 0.9;
        blur = true;
        window-padding-x = 8;
        window-padding-y = 8;
        cursor-style = "bar";
        shell-integration = "bash";
      };
    };
  };
}
