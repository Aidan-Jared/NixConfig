{ self, inputs, ... }:
{
  flake.homeModules.ewwBar = { pkgs, lib, ... }: {

    programs.eww = {
      enable = true;
      package = pkgs.eww;
      systemd.enable = true;
    };

    # Plain files symlinked — no Nix string escaping issues with eww's ${} syntax
    home.file = {
      ".config/eww/eww.yuck".source = ./eww.yuck;
      ".config/eww/eww.scss".source = ./eww.scss;
    };

    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.eww-niri-workspaces
      pkgs.swaynotificationcenter
      pkgs.wlogout
      pkgs.brightnessctl
      pkgs.iw
      pkgs.wirelesstools
    ];

    # swaync — replaces Noctalia's notification daemon
    services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        control-center-positionX = "right";
        control-center-positionY = "top";
        layer = "top";
        control-center-layer = "top";
        hide-on-clear = false;
        hide-on-action = true;
        control-center-margin-top    = 8;
        control-center-margin-bottom = 0;
        control-center-margin-right  = 20;
        control-center-margin-left   = 0;
        timeout          = 5;
        timeout-low      = 2;
        timeout-critical = 0;
        fit-to-screen    = true;
        relative-timestamps = true;
        notification-window-width = 340;
        keyboard-shortcuts = true;
        image-visibility   = "when-available";
        transition-time    = 200;
        widgets = [ "inhibitors" "title" "dnd" "notifications" ];
        widget-config = {
          inhibitors = { text = "Inhibitors"; button-text = "Clear all"; clear-all-button = true; };
          title      = { text = "Notifications"; clear-all-button = true; button-text = "Clear all"; };
          dnd        = { text = "Do not disturb"; };
        };
      };
      style = ''
        * {
          font-family: "FiraCode Nerd Font Mono";
          font-weight: 500;
          font-size: 13px;
        }

        .notification-row { outline: none; }
        .notification-row:focus,
        .notification-row:hover { background: rgba(40, 40, 58, 0.7); }

        .notification {
          background:    rgba(28, 28, 38, 0.92);
          border:        1px solid rgba(140, 140, 180, 0.18);
          border-radius: 12px;
          margin:        6px 12px;
          padding:       12px;
          color:         #e0e0f0;
        }

        .notification-content {
          background:    transparent;
          border-radius: 10px;
        }

        .notification-default-action {
          background:    transparent;
          border-radius: 10px;
          color:         #e0e0f0;
        }
        .notification-default-action:hover {
          background: rgba(142, 180, 227, 0.12);
        }

        .close-button {
          background:    rgba(227, 107, 142, 0.2);
          color:         #e36b8e;
          border-radius: 100%;
          min-width:     24px;
          min-height:    24px;
        }
        .close-button:hover { background: rgba(227, 107, 142, 0.4); }

        .notification-action {
          background:    rgba(28, 28, 38, 0.7);
          border:        1px solid rgba(140, 140, 180, 0.18);
          border-radius: 8px;
          color:         #e0e0f0;
          margin:        4px;
        }
        .notification-action:hover { background: rgba(142, 180, 227, 0.2); }

        .control-center {
          background:    rgba(18, 18, 24, 0.96);
          border:        1px solid rgba(140, 140, 180, 0.18);
          border-radius: 16px;
          padding:       12px;
          color:         #e0e0f0;
        }

        .control-center-list { background: transparent; }
        .blank-window        { background: alpha(black, 0.25); }

        .widget-title {
          color:     rgba(224, 224, 240, 0.55);
          font-size: 12px;
          margin:    8px 0 4px;
        }
        .widget-title > button {
          background:    rgba(28, 28, 38, 0.6);
          border:        1px solid rgba(140, 140, 180, 0.18);
          border-radius: 8px;
          color:         #e0e0f0;
        }
        .widget-title > button:hover {
          background: rgba(227, 107, 142, 0.2);
          color:      #e36b8e;
        }

        .widget-dnd > switch {
          background:    rgba(28, 28, 38, 0.6);
          border-radius: 100px;
        }
        .widget-dnd > switch:checked { background: rgba(142, 180, 227, 0.4); }

        .widget-inhibitors > button {
          background:    rgba(28, 28, 38, 0.6);
          border:        1px solid rgba(140, 140, 180, 0.18);
          border-radius: 8px;
          color:         #e0e0f0;
        }
      '';
    };
  };
}
