{ inputs, ... }: {
  flake.homeModules.vibepanel = { pkgs, lib, ... }: {
    home.packages = [
      inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default; 
      systemd.enable = false;

      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;

        modules-left = [ "mango/workspaces" "mango/layout" "mango/window" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "battery"
        ];

        "mango/workspaces" = {
          format = "{icon}";
          ignore-hidden = true;
          "on-click" = "activate";
          "on-click-right" = "deactivate";
          "sort-by-id" = true;
        };

        "mango/window" = {
          format = "[{layout}] {title}";
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %d %B %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        tray = {
          icon-size = 18;
          spacing = 8;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "婢 muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          "on-click" = "pavucontrol";
        };

        network = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ipaddr}";
          format-disconnected = "⚠ disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        };

        cpu = {
          format = " {usage}%";
          interval = 5;
        };

        memory = {
          format = " {used:0.1f}G/{total:0.1f}G";
          interval = 5;
        };

        battery = {
          states = { warning = 30; critical = 15; };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };
      };

      style = ''
      * {
        font-family: "Fira Code";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(24, 24, 24, 0.85);
        color: #e0e0e0;
      }

      #workspaces {
        border-radius: 6px;
        margin-left: 6px;
        padding: 0 6px;
        background: rgba(40, 40, 40, 0.76);
      }

      #workspaces button {
        border: none;
        background: none;
        box-shadow: inherit;
        text-shadow: inherit;
        color: #ddca9e;
        padding: 2px 6px;
      }

      #workspaces button.hidden { color: #6e6e6e; }
      #workspaces button.visible { color: #ddca9e; }
      #workspaces button:hover { color: #d79921; }

      #workspaces button.active {
        background-color: #ddca9e;
        color: #282828;
        border-radius: 4px;
      }

      #workspaces button.urgent {
        background-color: #ef5e5e;
        color: #282828;
        border-radius: 4px;
      }

      #window {
        padding: 0 10px;
        color: #edc493;
      }

      #clock,
      #tray,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #battery {
        padding: 0 10px;
      }

      #battery.warning { color: #f9c74f; }
      #battery.critical { color: #ef5e5e; }
    '';
    };

  };
}
