{ self, inputs, ... }:
{
  flake.homeModules.stylix = { pkgs, lib, config, ... }: {

    stylix = {
      enable = true;
      polarity = "dark";

      opacity = {
        terminal = 0.9;
        applications = 0.9;
      };

      image = pkgs.runCommand "wallpaper.png" {
        nativeBuildInputs = [ pkgs.imagemagick ];
      } ''
        convert ${self.wallpaper} $out
      '';
      #   cursor = {
      #   name = "DMZ-Black";
      #   size = 24;
      #   package = pkgs.vanilla-dmz;
      # };
      fonts = {
        serif = {
          package = pkgs.fira;
          name = "Fira Sans";
        };

        sansSerif = {
          package = pkgs.fira;
          name = "Fira Sans";
        };

        monospace = {
          package = pkgs.maple-mono.NF;
          name = "Maple Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
       };

      base16Scheme = "${pkgs.base16-schemes}/share/themes/eldritch.yaml";      
      override = {
        base08 = "ff4444";  # red — errors
        base09 = "ff8800";  # orange — warnings
      };
    };

  };
}
