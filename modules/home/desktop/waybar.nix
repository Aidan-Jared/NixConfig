{ inputs, ... }: {
  flake.homeModules.vibepanel = { pkgs, lib, ... }: {
    home.packages = [
      inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.waybar = {
      enable = true;
      # Alexays/Waybar master - the mango/* modules (workspaces, window,
      # layout, keymode) are documented at
      # https://github.com/Alexays/Waybar/wiki/Module:-Mango
      # and may not have landed in nixpkgs' waybar yet.
      package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default;
      systemd.enable = false;

      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        margin = "5 0";

        # ---- groups: each one renders as its own rounded pill (#id in css) ----

        "group/left" = {
          orientation = "horizontal";
          modules = [ "mango/workspaces" "mango/layout" ];
        };

        "group/left-hidden" = {
          orientation = "horizontal";
          drawer = {
            "transition-duration" = 500;
            "transition-left-to-right" = false;
            "click-to-reveal" = true;
          };
          modules = [ "custom/arrow-right" "battery" "cpu_graph" "memory" ];
        };

        "group/left-hidden-top" = {
          orientation = "horizontal";
          modules = [ "custom/arrow-left" "group/left-hidden" ];
        };

        "group/right" = {
          orientation = "horizontal";
          modules = [ "mango/keymode" "pulseaudio" "network" "tray" ];
        };

        "group/right-hidden" = {
          orientation = "horizontal";
          drawer = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
            "click-to-reveal" = true;
          };
          modules = [ "custom/arrow-left-2" "custom/nvidia" ];
        };

        modules-left = [ "group/left-hidden-top" "group/left" "mango/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "group/right" "group/right-hidden" ];

        # ---- module configs ----

        "mango/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            urgent = "";
            empty = "";
          };
          hide-empty = false;
          "on-click" = "activate";
          "on-click-middle" = "toggle";
          "on-click-right" = "toggle";
          overview-label = "";
        };

        "mango/layout" = {
          format = "[] {symbol}";

          format-tile = "▦ {symbol}";
          format-scroller = "⇄ {symbol}";
          format-monocle = "◻ {symbol}";
          format-grid = "⊞ {symbol}";
          format-deck = "▤ {symbol}";
          format-center_tile = "◈ {symbol}";
          format-dwindle = "🌀 {symbol}";
          format-fair = "⚖ {symbol}";

          # vertical-oriented variants of the above, marked with ↕
          format-vertical_tile = "▦↕ {symbol}";
          format-right_tile = "▦→ {symbol}";
          format-vertical_scroller = "⇅ {symbol}";
          format-vertical_grid = "⊞↕ {symbol}";
          format-vertical_deck = "▤↕ {symbol}";
          format-vertical_fair = "⚖↕ {symbol}";
        };

        "mango/window" = {
          format = "{title}";
          icon = true;
          icon-size = 18;
          expand = true;
          "max-length" = 45;
        };

        # hidden automatically when no non-default keymode is active
        "mango/keymode" = {
          format = "[{mode}]";
          format-resize = " Resizing";
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %d %B %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        tray = {
          icon-size = 13;
          spacing = 12;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "on-click-right" = "pavucontrol";
        };

        network = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ipaddr}";
          format-disconnected = "󱛅 disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        };

        cpu_graph = {
          format = " {usage}%";
          graph_type = "line";
          width = 10;
          interval = 2;
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

        "custom/nvidia" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,utilization.memory --format=csv,nounits,noheader | sed 's/\\([0-9]\\+\\), \\([0-9]\\+\\)/\\1% 🌡️\\2°C/g \\3% '";
          format = "{} ";
          interval = 2;
        };

        # drawer toggle glyphs, matching cebem1nt's arrow modules
        "custom/arrow-left" = { format = ""; tooltip = false; };
        "custom/arrow-right" = { format = ""; tooltip = false; };
        "custom/arrow-left-2" = { format = ""; tooltip = false; };
      };

      style = ''
        @define-color bg            rgba(24, 24, 24, 0.85);
        @define-color module-bg     rgba(40, 40, 40, 0.85);
        @define-color tooltip-bg    @module-bg;
        @define-color inactive      #6e6e6e;
        @define-color fg            #e0e0e0;
        @define-color workspace-fg  @fg;
        @define-color highlight     @inactive;
        @define-color accent        #ddca9e;

        @define-color red           #ef5e5e;
        @define-color blue          #89b4fa;
        @define-color yellow        #f9c74f;
        @define-color green         #a6e3a1;

        * {
          font-family: "Fira Code", "JetBrainsMono Nerd Font";
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 0;
          padding: 0;
          text-shadow: none;
        }

        window#waybar {
          font-weight: 700;
          font-size: 13px;
          background: transparent;
          color: @fg;
        }

        /* ---------------- pill groups ---------------- */
        #left,
        #right,
        #left-hidden-top,
        #right-hidden {
          padding: 2px 10px;
          border-radius: 15px;
          background: @module-bg;
        }

        #left-hidden-top,
        #right-hidden {
          padding: 0 12px;
        }

        #left,
        #right {
          margin: 0 8px;
        }

        #clock {
          background: @module-bg;
          padding: 1px 18px;
          border-radius: 15px;
        }

        /* ---------------- mango/workspaces ---------------- */
        #workspaces button {
          color: @workspace-fg;
          font-size: 14px;
          border-radius: 100%;
          padding: 0 2px;
          margin: 0 3px;
        }

        #workspaces button:hover { background: transparent; color: @yellow; }
        #workspaces button.empty { color: @inactive; }

        #workspaces button.active {
          background-color: @accent;
          color: @bg;
          border-radius: 100%;
        }

        #workspaces button.urgent {
          background-color: @red;
          color: @bg;
          border-radius: 100%;
        }

        #workspaces button.current_output { font-weight: bold; }
        #workspaces button.overview { color: @yellow; }

        /* ---------------- mango/layout ---------------- */
        #layout { color: @fg; padding: 0 8px; }

        #layout.tile         { color: @green; }
        #layout.scroller     { color: @blue; }
        #layout.monocle      { color: @yellow; }
        #layout.grid         { color: @accent; }
        #layout.deck         { color: @yellow; }
        #layout.center_tile  { color: @green; }
        #layout.dwindle      { color: @red; }
        #layout.fair         { color: @blue; }

        #layout.vertical_tile,
        #layout.right_tile,
        #layout.vertical_scroller,
        #layout.vertical_grid,
        #layout.vertical_deck,
        #layout.vertical_fair {
          color: @inactive;
        }

        /* ---------------- mango/window ---------------- */
        #window { padding: 1px 7px; color: @fg; }
        #window.empty { padding: 0; min-width: 0; }
        #window.solo { font-weight: bold; }

        /* ---------------- mango/keymode ---------------- */
        #keymode { padding: 0 10px; border-radius: 4px; }
        #keymode.resize { background: @red; color: @bg; }

        /* ---------------- everything else ---------------- */
        #tray { padding: 1px 6px; }
        #pulseaudio { padding: 1px 8px 1px 4px; }
        #cpu_graph, #memory, #custom-nvidia, #battery { padding: 1px 7px; }

        #cpu_graph.warning,
        #memory.warning,
        #battery.warning {
          color: @yellow;
          background: unset;
        }

        #memory.critical,
        #battery.critical {
          color: @red;
        }

        #network.disconnected { color: @red; }

        #custom-arrow-left,
        #custom-arrow-right,
        #custom-arrow-left-2 {
          color: @blue;
        }

        /* ---------------- misc: tooltips/menus ---------------- */
        tooltip {
          border-radius: 15px;
          background: @tooltip-bg;
        }

        tooltip label {
          padding: 3px 10px;
          color: @fg;
          font-weight: 700;
        }

        menu {
          border-radius: 10px;
          font-weight: 700;
          color: @fg;
          background: @tooltip-bg;
        }

        menu > * { padding: 3px 0px; }
        menu > *:hover { border-radius: 10px; background-color: @highlight; }

        slider { opacity: 0; box-shadow: none; }

        trough {
          min-width: 50px;
          min-height: 5px;
          border-radius: 8px;
          background: @inactive;
        }

        trough highlight {
          border-radius: 8px;
          background-color: @fg;
        }
      '';
    };
  };
}
