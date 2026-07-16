{ self, inputs, ... }: {
  flake.homeModules.matrix = { pkgs, ... }: {
    home.packages = with pkgs; [
      element-desktop
    ];
  };

  flake.homeModules.discord = { pkgs, ... }: {
    home.packages = with pkgs; [
      vesktop
    ];
    programs.vesktop = {
        enable = true;

        vencord.settings = {
          autoUpdate = true;
          autoUpdateNotification = true;
          notifyAboutUpdates = true;

          plugins = {
            ClearURLs.enabled = true;
            FixYoutubeEmbeds.enabled = true;
          };
        };
      };
    };
}
