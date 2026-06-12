{ self, inputs, ... }: {
  flake.homeModules.niri = { pkgs, lib, config, ... }: {

    options.myConfig.niri.terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
    };

    config.home.packages = with pkgs; [
      ghostty
      grim
      slurp
      swappy
      wl-clipboard
      xwayland-satellite
      alsa-utils
    ];

    config.programs.niri.settings = {
      prefer-no-csd = false;

      input = {
        keyboard.xkb.layout = "us";
        touchpad.natural-scroll = false;
        mouse.accel-profile = "flat";
      };

      binds = {
        "Mod+T".action.spawn          = config.myConfig.niri.terminal;

        "Mod+Q".action.close-window          = null;
        "Mod+F".action.maximize-column       = null;
        "Mod+G".action.fullscreen-window     = null;
        "Mod+Shift+F".action.toggle-window-floating = null;
        "Mod+C".action.center-column         = null;

        "Mod+H".action.focus-column-left     = null;
        "Mod+L".action.focus-column-right    = null;
        "Mod+K".action.focus-window-up       = null;
        "Mod+J".action.focus-window-down     = null;

        "Mod+Left".action.focus-column-left  = null;
        "Mod+Right".action.focus-column-right = null;
        "Mod+Up".action.focus-window-up      = null;
        "Mod+Down".action.focus-window-down  = null;

        "Mod+Shift+H".action.move-column-left  = null;
        "Mod+Shift+L".action.move-column-right = null;
        "Mod+Shift+K".action.move-window-up    = null;
        "Mod+Shift+J".action.move-window-down  = null;

        "Mod+1".action.focus-workspace = "w0";
        "Mod+2".action.focus-workspace = "w1";
        "Mod+3".action.focus-workspace = "w2";
        "Mod+4".action.focus-workspace = "w3";
        "Mod+5".action.focus-workspace = "w4";
        "Mod+6".action.focus-workspace = "w5";
        "Mod+7".action.focus-workspace = "w6";
        "Mod+8".action.focus-workspace = "w7";
        "Mod+9".action.focus-workspace = "w8";
        "Mod+0".action.focus-workspace = "w9";

        "Mod+Shift+1".action.move-column-to-workspace = "w0";
        "Mod+Shift+2".action.move-column-to-workspace = "w1";
        "Mod+Shift+3".action.move-column-to-workspace = "w2";
        "Mod+Shift+4".action.move-column-to-workspace = "w3";
        "Mod+Shift+5".action.move-column-to-workspace = "w4";
        "Mod+Shift+6".action.move-column-to-workspace = "w5";
        "Mod+Shift+7".action.move-column-to-workspace = "w6";
        "Mod+Shift+8".action.move-column-to-workspace = "w7";
        "Mod+Shift+9".action.move-column-to-workspace = "w8";
        "Mod+Shift+0".action.move-column-to-workspace = "w9";

        "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
        "Mod+V".action.spawn-sh = "${pkgs.alsa-utils}/bin/amixer sset Capture toggle";

        "Mod+Ctrl+H".action.set-column-width = "-5%";
        "Mod+Ctrl+L".action.set-column-width = "+5%";
        "Mod+Ctrl+J".action.set-window-height = "-5%";
        "Mod+Ctrl+K".action.set-window-height = "+5%";

        "Mod+WheelScrollDown".action.focus-column-left    = null;
        "Mod+WheelScrollUp".action.focus-column-right     = null;
        "Mod+Ctrl+WheelScrollDown".action.focus-workspace-down = null;
        "Mod+Ctrl+WheelScrollUp".action.focus-workspace-up     = null;

        "Mod+Ctrl+S".action.spawn-sh   = "${lib.getExe pkgs.grim} -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Mod+Shift+E".action.spawn-sh  = "${pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe pkgs.swappy} -f -";
        "Mod+Shift+S".action.spawn-sh  = lib.getExe (pkgs.writeShellApplication {
          name = "screenshot";
          text = ''
            ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -w 0)" - \
            | ${pkgs.wl-clipboard}/bin/wl-copy
          '';
        });
      };

      layout = {
        gaps = 5;
        focus-ring = {
          width = 2;
        };
      };

      # workspaces = {
      #   "w0" = ws; "w1" = ws; "w2" = ws; "w3" = ws; "w4" = ws;
      #   "w5" = ws; "w6" = ws; "w7" = ws; "w8" = ws; "w9" = ws;
      # };

      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
    };
  };
}
