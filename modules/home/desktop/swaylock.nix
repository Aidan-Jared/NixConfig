{ inputs, self, ... }: {

  flake.wrappersModules.swaylock = { config, lib, pkgs, ... }: {
    package = pkgs.swaylock-effects;
    settings = {
      image =  let
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
      scaling="fill";
      effect-blur="8x3";
      fade-in=0.6;
      effect-vignette="0.5:0.5";

      # --- Clock ---;
      clock=true;
      indicator=true;
      font="Fira Code";
      timestr="%I:%M %p";
      datestr="%A, %B %d";

      # --- Indicator Layout (eldritch greyscale) ---;
      indicator-radius=150;
      indicator-thickness=7;
      ring-color="38383cff";        # stone, idle ring
      ring-clear-color="8a8a8eff";  # fog, typing
      ring-ver-color="6a5a78ff";    # sigil, verifying
      ring-wrong-color="6b3232ff";  # blight, wrong password
      inside-color="00000000";
      inside-clear-color="00000000";
      inside-ver-color="00000000";
      inside-wrong-color="00000000";


      text-color="d4d0c4ff";        # bone
      text-clear-color="00000000";
      text-ver-color="d4d0c4ff";
      text-wrong-color="ece8daff";  # pale, for emphasis on error
      text-caps-lock-color="ece8daff";
      key-hl-color="6a5a7888";      # sigil
      bs-hl-color="6b323288";       # blight

      indicator-idle-visible=false;
    };
  };

  flake.wrappersModules.swayidle = { config, lib, pkgs, ... }: {
      timeouts = [
        {
          timeout = 300; # 5 min
          command = "swaylock";
        }
        {
          timeout = 600; # 10 min
          command = "wlopm --off '*'"; # so use wlopm instead of `swaymsg output * power off`)
          resumeCommand = "wlopm";
        }
        {
          timeout = 900; # 15 min
          command = "systemctl suspend";
        }
      ];

      # discrete swayidle events
      events = {
        before-sleep = "swaylock";
        lock = "swaylock";
      };
  };

  perSystem = { pkgs, ... }: {
    packages.swaylock = inputs.wrapper-modules.wrappers.swaylock.wrap {
      inherit pkgs;
      imports = [
        self.wrappersModules.swaylock
      ];
    };
    packages.swayidle = inputs.wrapper-modules.wrappers.swayidle.wrap {
      inherit pkgs;
      imports = [
        self.wrappersModules.swayidle
      ];
    };
  };
}
