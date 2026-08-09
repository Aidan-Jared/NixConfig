  { inputs, ... }: {
    flake.homeModules.waybar = { pkgs, lib, ... }: {
      home.packages = [
        inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      services.swaync = {
        enable = true;
        settings = {
          positionX = "right";
          positionY = "top";
          layer = "overlay";
          control-center-layer = "top";
          layer-shell = true;
          cssPriority = "application";
          control-center-margin-top = 0;
          control-center-margin-bottom = 0;
          control-center-margin-right = 0;
          control-center-margin-left = 0;
          notification-2fa-action = true;
          notification-inline-replies = false;
          notification-icon-size = 64;
          notification-body-image-height = 100;
          notification-body-image-width = 200;
        };
      };

      programs.waybar = {
        enable = true;
        package =
          (inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default).overrideAttrs
            (old: {
              mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Dmango=true" ];
            });
        systemd.enable = false;

          settings.mainBar = {
            layer= "top";
            position= "top";
            height= 28;
            spacing= 0;

            modules-left= [
                "mango/workspaces"
                "mango/layout"
                "mango/window"
            ];

            "modules-center"= [
                "clock"
            ];
            "modules-right"= [
                "network"
                "wireplumber"
                "temperature"
                "cpu"
                "memory"
                "battery"
            ];

            "mango/workspaces"= {
                format = "{index}";
                on-click = "activate";
                on-click-right = "toggle";
                hide-empty = false;
                current-only = false;
                overview-label = "OVERVIEW";
            };

            "mango/window"= {
                "format"= "{title}";
                "icon"= true;
                "icon-size"= 16;
                "swap-icon-label"= false;
                "max-length"= 70;
                "expand"= true;
                "tooltip"= false;
                "rewrite"= {
                  "^$"= "Workspace Overview";
                };
              };


            "clock"= {
              "format"= "{:%a %d %b  %H:%M}";
              "format-alt"= "{:%Y-%m-%d %H:%M}";
              "tooltip-format"= "<span weight='bold'>{:%A; %d %B %Y}</span>\n<tt>{calendar}</tt>";
              "calendar"= {
                "mode"= "month";
                "mode-mon-col"= 3;
                "weeks-pos"= "left";
                "on-scroll"= 1;
                "format"= {
                  "months"= "<span weight='bold'>{}</span>";
                  "days"= "{}";
                  "weeks"= "<span color='#6b7280'>W{}</span>";
                  "weekdays"= "<span color='#4b5563'>{}</span>";
                  "today"= "<span background='#d9c36a' color='#111111'>{}</span>";
                };
              };
            };

            "network"= {
              "format-wifi"= "{icon} {signalStrength:>2}%";
              "format-ethernet"= "󰈀";
              "format-linked"= "󰈀";
              "format-disconnected"= "󰖪";
              "format-icons"= [
                "󰤯"
                "󰤟"
                "󰤢"
                "󰤥"
                "󰤨"
              ];
              "tooltip-format"= "{ifname} {ipaddr}/{cidr}";
              "tooltip-format-wifi"= "{essid}\nSignal= {signalStrength}%\n{ipaddr}/{cidr}";
            };
    
          "wireplumber"= {
            "format"= "󰕾 {volume:>2}%";
            "format-muted"= "󰝟 muted";
            "format-icons"= {
              "default"= [ "󰕿" "󰖀" "󰕾" ];
            };
            "scroll-step"= 5;
            "on-click"= "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "tooltip-format"= "{node_name} {volume}%";
          };

          "cpu"= {
            "format"= "󰍛 {usage:>2}%";
            "tooltip"= false;
          };

          "memory"= {
            "format"= "󰘚 {}%";
            "tooltip-format"= "{used:0.1f}G / {total:0.1f}G";
          };

          "battery"= {
            "states"= {
              "warning"= 30;
              "critical"= 15;
            };
            "format"= "{icon} {capacity:>2}%";
            "format-charging"= "󰂄 {capacity:>2}%";
            "format-plugged"= "󰂄 {capacity:>2}%";
            "format-full"= "󰁹 100%";
            "format-alt"= "BAT {time}";
            "format-icons"= [
              "󰂎"
              "󰁺"
              "󰁼"
              "󰁾"
              "󰂀"
              "󰁹"
            ];
            "tooltip-format"= "{capacity}% {timeTo}\n{power:0.1f}W";
          };
                          
          "custom/power"= {
            format= "⏻";
            tooltip= false;
            on-click= "wlogout";
            on-click-right= "systemctl poweroff";
            on-click-middle= "systemctl reboot";
          };
          # "mpris"= {
          #   format= "{player_icon} {artist} - {title}";
          #   format-paused= "{status_icon} {artist} - {title}";
          #   on-click= "playerctl play-pause";
          #   on-click-middle= "playerctl previous";
          #   on-click-right= "playerctl next";
          #   player-icons= {
          #     default= "▶";
          #     spotify= "󰓇";
          #     firefox= "󰈹";
          #     chromium= "";
          #   };
          #   "status-icons"= {
          #     playing= "󰐊";
          #     paused= "󰏤";
          #     stopped= "󰓛";
          #   };
          #   max-length= 40;
          #   tooltip-format= "{player} : {artist} - {title}";
          #   };

        };

      style = ''

        @define-color surface alpha(@background, 0.94);
        @define-color surface-strong alpha(shade(@background, 0.97), 0.98);
        @define-color surface-muted alpha(shade(@background, 0.92), 0.9);
        @define-color line alpha(shade(@foreground, 0.78), 0.24);
        @define-color line-strong alpha(shade(@foreground, 0.72), 0.36);
        @define-color text @foreground;
        @define-color text-muted alpha(@foreground, 0.58);
        @define-color accent @color4;
        @define-color accent-soft alpha(@color4, 0.16);
        @define-color accent-alt @color3;
        @define-color good @color2;
        @define-color warn @color1;

        * {
            border: none;
            border-radius: 0;
            min-height: 0;
            font-family: "MapleMono Nerd Font", "Fira Code", monospace;
            font-size: 13px;
            font-weight: 700;
        }

        window#waybar {
            background: @surface;
            color: @text;
            border-bottom: 1px solid @line-strong;
        }

        tooltip {
            background: @surface-strong;
            color: @text;
            border: 1px solid @line-strong;
        }

        tooltip label {
            padding: 2px 6px;
        }

        #workspaces,
        #window,
        #network,
        #wireplumber,
        #cpu,
        #memory,
        #battery,
        #clock {
            margin-top: 6px;
            margin-bottom: 6px;
            padding-top: 1px;
            padding-bottom: 3px;
            background: @surface-muted;
            color: @text;
            border: 1px solid @line;
        }

        #workspaces {
            margin-left: 8px;
            padding: 2px 4px;
        }

        #workspaces button {
            min-width: 22px;
            margin: 0 2px;
            padding: 1px 10px 3px 10px;
            background: transparent;
            color: @text-muted;
            border-bottom: 2px solid transparent;
        }

        #layout {
          color: @text-muted;
          padding: 0 5px;
        }

        #workspaces button:hover {
            background: @accent-soft;
            color: @text;
        }

        #workspaces button.active {
            background: alpha(@accent, 0.1);
            color: @text;
            border-bottom: 2px solid @accent;
        }

        #workspaces button.urgent {
            background: alpha(@warn, 0.18);
            color: @warn;
            border-bottom: 2px solid @warn;
        }

        #workspaces button.hidden {
            color: @text-muted;
        }

        #window {
            margin-left: 8px;
            margin-right: 8px;
            padding-top: 1px;
            padding-right: 14px;
            padding-bottom: 3px;
            padding-left: 14px;
        }

        #window.empty {
            color: @text-muted;
        }

        #network,
        #wireplumber,
        #cpu,
        #memory,
        #battery,
        #clock {
            padding-top: 1px;
            padding-right: 12px;
            padding-bottom: 3px;
            padding-left: 12px;
        }

        #network {
            color: @accent;
        }

        #wireplumber {
            color: @accent;
        }

        #wireplumber.muted {
            color: @text-muted;
        }

        #network.disconnected {
            color: @warn;
        }

        #cpu {
            color: @accent-alt;
        }

        #memory {
            color: @color6;
        }

        #battery {
            color: @good;
        }

        #battery.warning {
            color: @accent-alt;
        }

        #battery.critical {
            color: @warn;
        }

        #battery.charging,
        #battery.plugged {
            color: @accent;
        }

        #clock {
            margin-right: 8px;
            color: @text;
        }
      '';
    };
  };
}
