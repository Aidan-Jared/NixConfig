{ pkgs, ... }:
{  # ── Waybar ────────────────────────────────────────────────────────────────
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer  = "top";
        position = "top";
        height = 32;
        modules-left   = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right  = [
          "pulseaudio"
          "network"
          "battery"
          "cpu"
          "memory"
          "tray"
        ];

        "niri/workspaces" = {
          on-click       = "activate";
          format         = "{id}";
          active-only    = false;
          all-outputs    = true;
        };

        "clock" = {
          format     = "{:%H:%M  %a %d %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "cpu" = {
          format   = "  {usage}%";
          interval = 2;
        };

        "memory" = {
          format   = "  {percentage}%";
          interval = 2;
        };

        "battery" = {
          format          = "{icon}  {capacity}%";
          format-icons    = [ "" "" "" "" "" ];
          format-charging = "  {capacity}%";
          states = { warning = 30; critical = 15; };
        };

        "network" = {
          format-wifi         = "  {essid}";
          format-ethernet     = "  {ifname}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format      = "{ipaddr}";
        };

        "pulseaudio" = {
          format        = "{icon}  {volume}%";
          format-muted  = "  muted";
          format-icons  = { default = [ "" "" "" ]; };
          on-click      = "${pkgs.pamixer}/bin/pamixer -t";
        };

        "tray" = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
      }

      .modules-left, .modules-center, .modules-right {
        padding: 0 8px;
      }

      #workspaces button {
        padding: 0 6px;
        color: #6c7086;
        background: transparent;
      }

      #workspaces button.active {
        color: #89b4fa;
        border-bottom: 2px solid #89b4fa;
      }

      #workspaces button:hover {
        color: #cdd6f4;
        background: rgba(255,255,255,0.05);
      }

      #clock { color: #a6e3a1; }
      #cpu   { color: #fab387; }
      #memory { color: #f38ba8; }
      #battery { color: #a6e3a1; }
      #battery.warning { color: #f9e2af; }
      #battery.critical { color: #f38ba8; }
      #network { color: #89dceb; }
      #pulseaudio { color: #cba6f7; }
      #tray { padding: 0 4px; }
    '';
  };
}
