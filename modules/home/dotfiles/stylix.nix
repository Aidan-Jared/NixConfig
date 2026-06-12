{ self, inputs, ... }:
{
  flake.homeModules.stylix = { pkgs, lib, ... }: {

    stylix = {
      enable   = true;
      polarity = "dark";
      image    = pkgs.runCommand "wallpaper.png" {
        nativeBuildInputs = [ pkgs.imagemagick ];
      } ''
        convert ${./wallpaper.webp} $out
      '';
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
          package = pkgs.nerd-fonts.fira-code;
          name = "Fira Code Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
