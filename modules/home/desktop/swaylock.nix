{ inputs, self, ... }: {

  flake.wrappersModules.swaylock = { config, lib, pkgs, ... }: {
    settings = {
      image = "${self.wallpaper}";
      color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
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
