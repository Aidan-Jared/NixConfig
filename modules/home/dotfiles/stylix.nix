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

      image = 
        let
          wallpaperStr = toString self.wallpaper;
        in
        if pkgs.lib.hasSuffix ".mp4" wallpaperStr then
          # Extract 1 frame from MP4 video to PNG
          pkgs.runCommand "wallpaper.png" { nativeBuildInputs = [ pkgs.ffmpeg ]; } ''
            ${pkgs.ffmpeg}/bin/ffmpeg -ss 00:00:01 -i ${self.wallpaper} -vframes 1 $out
          ''
        else if (pkgs.lib.hasSuffix ".jpg" wallpaperStr || pkgs.lib.hasSuffix ".jpeg" wallpaperStr || pkgs.lib.hasSuffix ".webp" wallpaperStr) then
          # Convert JPG/JPEG/WebP image to PNG using ffmpeg
          pkgs.runCommand "wallpaper.png" { nativeBuildInputs = [ pkgs.ffmpeg ]; } ''
            ${pkgs.ffmpeg}/bin/ffmpeg -i ${self.wallpaper} $out
          ''
        else
          self.wallpaper;
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
