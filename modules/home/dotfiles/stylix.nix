{ self, inputs, ... }:
{
  flake.homeModules.stylix = { pkgs, lib, config, ... }: {

    stylix = {
      enable = true;
      polarity = "dark";
      # image = self.wallpaper;

      image = pkgs.runCommand "wallpaper.png" {
        nativeBuildInputs = [ pkgs.imagemagick ];
      } ''
        convert ${self.wallpaper} $out
      '';
        cursor = {
        name = "DMZ-Black";
        size = 24;
        package = pkgs.vanilla-dmz;
      };
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
      override = {
        base08 = "ff4444";  # red — errors
        base09 = "ff8800";  # orange — warnings
      };
    };

    xdg.configFile."noctalia/colors.json".text = builtins.toJSON {
      mSurface        = "#${config.lib.stylix.colors.base00}";
      mSurfaceVariant = "#${config.lib.stylix.colors.base01}";
      mOnSurface      = "#${config.lib.stylix.colors.base05}";
      mOnSurfaceVariant = "#${config.lib.stylix.colors.base04}";
      mPrimary        = "#${config.lib.stylix.colors.base0B}";
      mOnPrimary      = "#${config.lib.stylix.colors.base00}";
      mSecondary      = "#${config.lib.stylix.colors.base0A}";
      mOnSecondary    = "#${config.lib.stylix.colors.base00}";
      mTertiary       = "#${config.lib.stylix.colors.base0C}";
      mOnTertiary     = "#${config.lib.stylix.colors.base00}";
      mError          = "#${config.lib.stylix.colors.base08}";
      mOnError        = "#${config.lib.stylix.colors.base00}";
      mOutline        = "#${config.lib.stylix.colors.base03}";
      mShadow         = "#${config.lib.stylix.colors.base00}";
      mHover          = "#${config.lib.stylix.colors.base0D}";
      mOnHover        = "#${config.lib.stylix.colors.base00}";
    };
  };
}
