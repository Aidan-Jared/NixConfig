{ self, inputs, ... }: {
  flake.homeModules.ghostty = { pkgs, ... }: {
    home.packages = [ pkgs.ghostty ];
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        font-size = 12;
        background-opacity = 0.9;
        window-padding-x = 8;
        window-padding-y = 8;
        cursor-style = "bar";
        shell-integration = "bash";
      };
    };
  };
}
