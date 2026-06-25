{ inputs, self, ... }: {

  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
    services.system76-scheduler.enable = true;
  };

  flake.wrappersModules.niri = { config, lib, pkgs, ... }: {
    
    options.terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
    };


    config = {
      settings = let
        noctaliaExe = lib.getExe inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      in {
        input = {
          keyboard = {
            xkb.layout = "us";
            repeat-rate = 40;
            repeat-delay = 250;
          };
          touchpad = {
            # natural-scroll = "false";
            # tap = "false";
          };
          mouse = {
            # natural-scroll = "false";
            accel-profile = "flat";
          };
        };

        binds = {
          "Mod+T".spawn = config.terminal;

          "Mod+Q".close-window = {};
          "Mod+O".toggle-overview = {};
          "Mod+F".maximize-column = {};
          "Mod+G".fullscreen-window = {};
          "Mod+Shift+F".toggle-window-floating = {};
          "Mod+Ctrl+F".switch-focus-between-floating-and-tiling = {};
          "Mod+C".center-column = {};
          "Mod+W".center-column = {};

          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+K".focus-window-up = {};
          "Mod+J".focus-window-down = {};
          "Mod+P".focus-workspace-up = {};
          "Mod+N".focus-workspace-down = {};

          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};

          "Mod+WheelScrollDown".focus-column-left = {};
          "Mod+WheelScrollUp".focus-column-right = {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-up = {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-down = {};

          "Mod+Shift+H".move-column-left = {};
          "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+K".move-window-up = {};
          "Mod+Shift+J".move-window-down = {};

          "Mod+Comma".consume-window-into-column = {};
          "Mod+Period".expel-window-from-column = {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+0".focus-workspace = 10;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;
          "Mod+Shift+0".move-column-to-workspace = 10;

          "Mod+Space".spawn = [ "${noctaliaExe}" "msg" "panel-toggle" "launcher" ];
          "Mod+S".spawn = [ "${noctaliaExe}" "msg" "panel-toggle" "control-center" ];
          "Mod+Shift+S".spawn = [ "${noctaliaExe}" "msg" "panel-toggle" "settings-toggle" ];

          "Mod+E".spawn-sh = "ghostty -e yazi";
          "Mod+Ctrl+E".spawn = "pcmanfm";
          "Mod+V".spawn-sh = "${config.pkgs.alsa-utils}/bin/amixer sset Capture toggle";

          "Mod+Escape".spawn = [ "${noctaliaExe}" "msg" "session lock" ];

          "Mod+Shift+P".power-off-monitors = {};

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute -l 1.4 @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessUp".spawn = [ "${noctaliaExe}" "msg" "brightness-up" ];
          "XF86MonBrightnessDown".spawn = [ "${noctaliaExe}" "msg" "brightness-down" ];
          "XF86Sleep".spawn = [ "${noctaliaExe}" "msg" "session lock-and-suspend" ];
          "XF86Standby".spawn = [ "${noctaliaExe}" "msg" "session lock-and-suspend" ];

          "Mod+Ctrl+H".set-column-width = "-5%";
          "Mod+Ctrl+L".set-column-width = "+5%";
          "Mod+Ctrl+J".set-window-height = "-5%";
          "Mod+Ctrl+K".set-window-height = "+5%";

          "Mod+Ctrl+S".spawn-sh  = "${lib.getExe config.pkgs.grim} -l 0 - | ${config.pkgs.wl-clipboard}/bin/wl-copy";
          "Mod+Shift+E".spawn-sh = "${config.pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe config.pkgs.swappy} -f -";
          "Print".spawn-sh = lib.getExe (config.pkgs.writeShellApplication {
            name = "screenshot";
            text = ''
              ${lib.getExe config.pkgs.grim} -g "$(${lib.getExe config.pkgs.slurp} -w 0)" - \
              | ${config.pkgs.wl-clipboard}/bin/wl-copy
            '';
          });
        };

        cursor = {
          xcursor-size = 10;
        };

        layout = {
          gaps = 5;
          focus-ring.width = 2;
        };

        window-rule = {
            geometry-corner-radius = 10;
            clip-to-geometry = true;
            opacity = 0.85;

            background-effect = {
              blur = true;
              xray = true;
            };
            match = _: { props = { app-id = "dev.noctalia.Noctalia.Settings"; }; };            open-floating = true;
            default-column-width = { fixed = 1080; };
            default-window-height = { fixed = 920; };
          };

        blur = {
          passes = 2;
          offset = 3.0;
          noise = 0.03;
          saturation = 1.0;
        };

        layer-rule = 
          {
            match = _: {
                           props = { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"; };
            };            
            background-effect = {
              xray = false;
              # blur = false;  # uncomment to disable blur on noctalia surfaces
            };
          };
          # {
          #   matches = [
          #     {
          #       namespace="nirimap";
          #     }
          #   ];
          # }
          # Option 1: blurred overview backdrop
          # {
          #   matches = [
          #     {
          #       namespace = "^noctalia-backdrop"; 
          #     }
          #   ];
          #   place-within-backdrop = true;
          # }
        xwayland-satellite.path = lib.getExe config.pkgs.xwayland-satellite;

        spawn-at-startup = [
         noctaliaExe 
         (lib.getExe inputs.system76-scheduler-niri.packages.${pkgs.stdenv.hostPlatform.system}.default)
        # (lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.pandora)
         (lib.getExe (
             pkgs.writeShellScriptBin "wallpaper"
             "${lib.getExe pkgs.swaybg} -i ${self.wallpaper} -m fill"
           ))
        ];
      };
    };
  };

  perSystem = { pkgs, ... }: {

    # packages.nirimap = let
    #   craneLib = inputs.crane.mkLib pkgs;
    # commonArgs = {
    #   src = inputs.nirimap;
    #   nativeBuildInputs = [ pkgs.pkg-config ];
    #   buildInputs = [ pkgs.gtk4 pkgs.gtk4-layer-shell ];
    # };
    # cargoArtifacts = craneLib.buildDepsOnly commonArgs;
    # in craneLib.buildPackage ( commonArgs // {
    #   inherit cargoArtifacts;
    # } );
    # packages.pandora = let
    #   craneLib = inputs.crane.mkLib pkgs;
    # commonArgs = {
    #   src = inputs.pandora;
    #   nativeBuildInputs = [ pkgs.pkg-config ];
    #   buildInputs = [ pkgs.gtk4 pkgs.gtk4-layer-shell ];
    # };
    # cargoArtifacts = craneLib.buildDepsOnly commonArgs;
    # in craneLib.buildPackage ( commonArgs // {
    #   inherit cargoArtifacts;
    # } );

    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [
        self.wrappersModules.niri 
      ];
    };
  };
}
