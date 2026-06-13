{ inputs, self, ... }: {

  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
  };

  flake.wrappersModules.niri = { config, lib, pkgs, ... }: {
    options.terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
    };

    config = {
      settings = let
        noctaliaExe = lib.getExe self.packages.${config.pkgs.stdenv.hostPlatform.system}.noctalia-shell;
      in {

        input = {
          keyboard = {
            xkb.layout = "us";
            repeat-rate = 40;
            repeat-delay = 250;
          };
          touchpad = {
            # natural-scroll = {};
            # tap = {};
          };
          mouse.accel-profile = "flat";
        };

        binds = {
          "Mod+T".spawn = config.terminal;

          "Mod+Q".close-window         = {};
          "Mod+F".maximize-column      = {};
          "Mod+G".fullscreen-window    = {};
          "Mod+Shift+F".toggle-window-floating = {};
          "Mod+C".center-column        = {};

          "Mod+H".focus-column-left    = {};
          "Mod+L".focus-column-right   = {};
          "Mod+K".focus-window-up      = {};
          "Mod+J".focus-window-down    = {};

          "Mod+Left".focus-column-left  = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up      = {};
          "Mod+Down".focus-window-down  = {};

          "Mod+Shift+H".move-column-left  = {};
          "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+K".move-window-up    = {};
          "Mod+Shift+J".move-window-down  = {};

          "Mod+1".focus-workspace = 0;
          "Mod+2".focus-workspace = 1;
          "Mod+3".focus-workspace = 2;
          "Mod+4".focus-workspace = 3;
          "Mod+5".focus-workspace = 4;
          "Mod+6".focus-workspace = 5;
          "Mod+7".focus-workspace = 6;
          "Mod+8".focus-workspace = 7;
          "Mod+9".focus-workspace = 8;
          "Mod+0".focus-workspace = 9;

          "Mod+Shift+1".move-column-to-workspace = 0;
          "Mod+Shift+2".move-column-to-workspace = 1;
          "Mod+Shift+3".move-column-to-workspace = 2;
          "Mod+Shift+4".move-column-to-workspace = 3;
          "Mod+Shift+5".move-column-to-workspace = 4;
          "Mod+Shift+6".move-column-to-workspace = 5;
          "Mod+Shift+7".move-column-to-workspace = 6;
          "Mod+Shift+8".move-column-to-workspace = 7;
          "Mod+Shift+9".move-column-to-workspace = 8;
          "Mod+Shift+0".move-column-to-workspace = 9;

          "Mod+A".spawn-sh = "${noctaliaExe} msg panel-toggle launcher";
          # "Mod+F".spawn = [ (lib.getExe pkgs.ghostty) "-e" (lib.getExe pkgs.yazi) ];
          "Mod+V".spawn-sh = "${config.pkgs.alsa-utils}/bin/amixer sset Capture toggle";

          "Mod+Escape".spawn-sh = "${noctaliaExe} msg session lock";

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86MonBrightnessUp".spawn-sh = "${noctaliaExe} msg brightness-up";
          "XF86MonBrightnessDown".spawn-sh = "${noctaliaExe} msg brightness-down";
          "XF86Sleep".spawn-sh = "${noctaliaExe} msg session lock-and-suspend";
          "XF86Standby".spawn-sh = "${noctaliaExe} msg session lock-and-suspend";
          # "XF86Standby".system = "Suspend";

          "Mod+Ctrl+H".set-column-width  = "-5%";
          "Mod+Ctrl+L".set-column-width  = "+5%";
          "Mod+Ctrl+J".set-window-height = "-5%";
          "Mod+Ctrl+K".set-window-height = "+5%";

          "Mod+WheelScrollDown".focus-column-left         = {};
          "Mod+WheelScrollUp".focus-column-right          = {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up     = {};


          "Mod+Ctrl+S".spawn-sh  = "${lib.getExe config.pkgs.grim} -l 0 - | ${config.pkgs.wl-clipboard}/bin/wl-copy";
          "Mod+Shift+E".spawn-sh = "${config.pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe config.pkgs.swappy} -f -";
          "Mod+Shift+S".spawn-sh = lib.getExe (config.pkgs.writeShellApplication {
            name = "screenshot";
            text = ''
              ${lib.getExe config.pkgs.grim} -g "$(${lib.getExe config.pkgs.slurp} -w 0)" - \
              | ${config.pkgs.wl-clipboard}/bin/wl-copy
            '';
          });
        };

        layout = {
          gaps = 5;
          focus-ring.width = 2;
        };

        window-rule = {
          geometry-corner-radius = 20;
          clip-to-geometry = true;

          background-effect = {
            blur = true;
            xray = false;
          };
        };

        blur = {
          passes = 2;
          offset = 3.0;
          noise = 0.03;
          saturation = 1.0;
        };

        layer-rules = [
          {
            matches = [{ namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"; }];
            background-effect = {
              xray = false;
              # blur = false;  # uncomment to disable blur on noctalia surfaces
            };
          }
          # Option 1: blurred overview backdrop
          {
            matches = [{ namespace = "^noctalia-backdrop"; }];
            place-within-backdrop = true;
          }
        ];
        xwayland-satellite.path = lib.getExe config.pkgs.xwayland-satellite;

        spawn-at-startup = [ noctaliaExe ];
      };
    };
  };

  perSystem = { pkgs, ... }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [ self.wrappersModules.niri ];
    };
  };
}
