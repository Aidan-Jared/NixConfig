{ inputs, self, ... }: {

  flake.wrappersModules.swaylock = { config, lib, pkgs, ... }: {
    settings = {
      image = "${self.wallpaper}";
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

      # --- Indicator Layout ---;
      indicator-radius=150;
      indicator-thickness=7;
      ring-color="ffffff88";
      ring-clear-color="88c0d0ff";
      ring-ver-color="ebcb8bff" ;
      #89dcebff;
      ring-wrong-color="bf616aff";
      inside-color="00000000";
      inside-clear-color="00000000";
      inside-ver-color="00000000";
      inside-wrong-color="00000000";


      text-color="ffffffff";
      text-clear-color="00000000";
      text-ver-color="ffffffff";
      text-wrong-color="ffffffff";
      text-caps-lock-color="ffffffff";
      key-hl-color="89dceb88";
      bs-hl-color="f38ba888";

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
