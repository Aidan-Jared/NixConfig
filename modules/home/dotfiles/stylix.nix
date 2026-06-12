{ self, inputs, ... }:
{
  flake.homeModules.stylix = { pkgs, lib, config, ... }: {

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
    # pass stylix colors into noctalia config
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
