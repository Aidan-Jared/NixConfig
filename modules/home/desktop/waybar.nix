  { inputs, ... }: {
    flake.homeModules.waybar = { pkgs, lib, ... }: {
      # home.packages = [
      #   inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
      # ];
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
        # Alexays/Waybar master - the mango/* modules (workspaces, window,
        # layout, keymode) are documented at
        # https://github.com/Alexays/Waybar/wiki/Module:-Mango
        # and may not have landed in nixpkgs' waybar yet.
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
                "custom/sep"
                "pulseaudio#mic"
                "pulseaudio#audio"
                "custom/sep"
            ];

            "modules-center"= [
                "mango/windows"
                "clock"
            ];
            "modules-right"= [
                "custom/sep"
                "network"
                "temperature"
                # "mpris"
                "cpu"
                "memory"
                "custom/power"
            ];

            "mango/workspaces"= {
                format = "{index}";
                on-click = "activate";
                on-click-right = "toggle";
                hide-empty = true;
                current-only = false;
                overview-label = "OVERVIEW";
            };

            # tray= {
            #     spacing= 10;
            # };

            clock= {
              format= "󰥔 {:%H:%M:%S}";
              format-alt= "󰃭 {:%d/%m/%Y}";
              interval= 1;
              tooltip= false;
              # on-click-right= "~/.config/mango/scripts/calendar.sh";
            };
            cpu= {
              format= "󰍛 {usage}%";
              tooltip= false;
              interval= 2;
            };

            memory= {
              format= "󰾅 {used:.1f}GB";
              tooltip= false;
              interval= 5;
            };

            temperature= {
              hwmon-path= "/sys/class/hwmon/hwmon4/temp1_input";
              interval= 5;
              critical-threshold= 80;
              format= "{icon} {temperatureC}°C";
              format-icons= [ ""  ""  "" ];
              tooltip= false;
            };

            battery= {
              states= {
                  good= 95;
                  warning= 30;
                  critical= 15;
              };
              format= "{icon} {capacity}%";
              format-plugged= "󰂄 {capacity}%";
              format-alt= "{icon} {time}";
              format-time= "{H}h{M}m";
              format-icons= [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            };

            network= {
              format-wifi= "󰤨 {essid}";
              format-ethernet= "󰈀 {ifname}";
              format-disconnected= "󰤭 Offline";
              tooltip-format= "{ipaddr} — {bandwidthUpBits} ↑ {bandwidthDownBits} ↓";
              interval= 5;
            };

            "pulseaudio#audio" = {
              format= "{icon} {volume}%";
              tooltip= false;
              format-muted= "󰝟 Muted";
              on-click= "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              on-scroll-up= "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+";
              on-scroll-down= "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%-";
              on-click-right= "pavucontrol";
              format-icons= {
                  headphone= "󰋋";
                  headset= "󰋎";
                  default= [ "󰕿"  "󰖀"  "󰕾" ];
              };
            };

            "pulseaudio#mic"= {
              format= "{format_source}";
              format-source= "󰍬 On";
              format-source-muted= "󰍭 Off";
              on-click= "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
              tooltip= false;
            };

            "custom/sep"= {
              format= "";
              interval= 0;
              tooltip= false;
            };
    
            "mango/window"= {
              format= "{title}";
              max-length= 30;
              rewrite= {
                  "^$"= "Desktop";
              };
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

          disk = {
              interval= 60;
              path= "/";
              format= "󰋊 {percentage_used}%";
              tooltip-format= "{used} usados de {total}";
          };
        };

          style = ''
            /* ---- eldritch greyscale palette ----
               void/abyss/stone/ash/fog/bone/pale form the grey ramp.
               sigil (desaturated violet) is the one "otherworldly" accent,
               used only for hover/active states. blight (muted blood-red)
               is used only for urgent/critical - nothing else is colored.
            */
            @define-color void        #0a0a0c;
            @define-color abyss       #141416;
            @define-color stone       #38383c;
            @define-color ash         #58585c;
            @define-color fog         #8a8a8e;
            @define-color bone        #d4d0c4;
            @define-color pale        #ece8da;

            @define-color sigil       #6a5a78;
            @define-color sigil-glow  rgba(106, 90, 120, 0.28);
            @define-color blight      #6b3232;
            @define-color blight-glow rgba(107, 50, 50, 0.28);

            @define-color transparent            rgba(10, 10, 12, 0.55);
            @define-color background-module      @transparent;
            @define-color border-color           @stone;
            @define-color color13                @sigil;

            /* legacy Catppuccin-named vars, remapped onto the grey ramp
               so the selectors further down don't all need touching */
            @define-color sapphire  @fog;
            @define-color mauve     @ash;
            @define-color rosewater @bone;
            @define-color sky       @fog;
            @define-color red       @blight;
            @define-color yellow    @sigil;
            @define-color teal      @ash;

            * {
                font-family: "Fira Code";
                font-weight: bold;
               	min-height: 0;  
                /* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
                font-size: 97%;
                  font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
              }

              window#waybar {
                  background: transparent;
                  border-radius: 0px;
                  color: @bone;
              }

              window#waybar.hidden {
                  opacity: 0;
              }

              tooltip {
                  background: @abyss;
                  border-radius: 12px;
                  border-width: 1px;
                  border-style: solid;
                  border-color: @border-color;
                  color: @bone;
              }

              /*-----module groups----*/
              .modules-left,
              .modules-center,
              .modules-right {
                  background-color: @background-module;
                  border-radius:15px;
                  border-bottom:2px solid @border-color;
             	padding-top: 2px;
             	padding-bottom: 0px;
             	padding-right: 4px;
             	padding-left: 4px;
              }

              #workspaces {
                  padding: 0px 1px;
                  border-radius: 15px;
                  font-weight: bold;
                  font-style: normal;
                  opacity:0.8;
                  color: @bone;
              }

              #taskbar button {
                  color: @fog;
                  box-shadow: none;
             	text-shadow: none;
                  border-radius: 30px;
                  padding-left: 4px;
                  padding-right: 4px;
                  transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
              }

              #taskbar button.active {
                  color: @pale;
                  border-radius: 50%;
                  background-color: @void;
                  border-radius: 15px 15px 15px 15px;
                  padding-left: 8px;
                  padding-right: 8px;
                  transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
              }

              #taskbar button:hover {
                  color: @pale;
                  border-radius: 10px;
               	padding-left: 2px;
                  padding-right: 2px;
                  transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
              }

              #backlight,
              #backlight-slider,
              #battery,
              #bluetooth,
              #clock,
              #cpu,
              #temperature,
              #idle_inhibitor,
              #keyboard-state,
              #memory,
              #mode,
              #mpris,
              #network,
              #power-profiles-daemon,
              #pulseaudio,
              #pulseaudio-slider,
              #taskbar,
              #temperature,
              #window,
              #wireplumber,
              #workspaces,
              #custom-backlight,
              #custom-browser,
              #custom-cava_mviz,
              #custom-cycle_wall,
              #custom-dot_update,
              #custom-file_manager,
              #custom-keybinds,
              #custom-keyboard,
              #custom-light_dark,
              #custom-lock,
              #custom-hint,
              #custom-hypridle,
              #custom-menu,
              #custom-playerctl,
              #custom-power_vertical,
              #custom-power,
              #custom-quit,
              #custom-reboot,
              #custom-settings,
              #custom-spotify,
              #custom-swaync,
              #custom-tty,
              #custom-updater,
              #custom-hyprpicker,
              #custom-weather,
              #custom-weather.clearNight,
              #custom-weather.cloudyFoggyDay,
              #custom-weather.cloudyFoggyNight,
              #custom-weather.default, 
              #custom-weather.rainyDay,
              #custom-weather.rainyNight,
              #custom-weather.severe,
              #custom-weather.showyIcyDay,
              #custom-weather.snowyIcyNight,
              #custom-weather.sunnyDay {
                color: @bone;
               	padding-right: 6px;
               	padding-left: 6px;;
              }

          #temperature.critical {
              background-color: @blight;
          }

          @keyframes blink {
              to {
                  color: @void;
              }
          }

          #backlight-slider slider,
          #pulseaudio-slider slider {
              min-width: 0px;
              min-height: 0px;
              opacity: 0;
              background-image: none;
              border: none;
              box-shadow: none;
          }

          #backlight-slider trough,
          #pulseaudio-slider trough {
              min-width: 80px;
              min-height: 5px;
              border-radius: 5px;
              background-color: @stone;
          }

          #backlight-slider highlight,
          #pulseaudio-slider highlight {
              min-height: 10px;
              border-radius: 5px;
              background-color: @sigil;
          }

          #pulseaudio-slider,
          #pulseaudio {
         	color: @color13;
          }

          #pulseaudio.muted {
              color: @blight;
          }

        #memory {
         	color: @sapphire;
        }

        #cpu {
         	color: @mauve;
        }

        #temperature {
         	color: @mauve;
        }

        #battery {
         	color: @rosewater;
        }

        #disk {
         	color: @sky;
        }

        #temperature.critical {
            background-color: @red;
        }

        #battery.critical:not(.charging) {
         	color: @blight;
         	animation-name: blink;
         	animation-duration: 3.0s;
         	animation-timing-function: steps(12);
         	animation-iteration-count: infinite;
         	animation-direction: alternate;
        }

        #custom-hypridle,
        #custom-lock,
        #idle_inhibitor {
            color: @teal;
        }

        #clock#2 {
            color: @pale;
        }

        #clock {
       	color: @sapphire;
            border-radius: 15px;
            border:2px solid @border-color;
        }
        #custom-updates {
            color: @yellow;
        }
        #swaync{
            color: @sigil;}

          /* Tags - ext/workspaces (mangowm) */
        #workspaces button {
            padding: 0 7px;
            color: @bone;
            background: transparent;
            border-radius: 8px;
            font-size: 95%;
            min-width: 22px;
            border-bottom: 2px solid @stone;
            transition: all 0.2s ease;
        }

      #workspaces button.active {
          color: @void;
          background-color: @bone;
          border-radius: 10px;
          padding: 0 10px;
          font-weight: bold;
          border-bottom: none;
      }

      #workspaces button.empty:not(.active) {
          color: @stone;
          border-bottom: none;
      }

      #workspaces button.urgent {
          color: @blight;
          background-color: @blight-glow;
          border-radius: 8px;
          border-bottom: none;
          animation-name: blink;
          animation-duration: 1s;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #workspaces button:hover {
          color: @sigil;
          background-color: @sigil-glow;
          border-radius: 8px;
      }

      #custom-sep {
          color: @stone;
          padding: 0 2px;
          font-size: 90%;
      }
      #mpris.paused {
          color: @fog;
      }
      #group-mpris-controls {
          background-color: rgba(20, 20, 22, 0.6);
          border-radius: 20px;
          padding: 0 4px;
          margin: 0 4px;
      }

      #custom-mpris-prev,
      #custom-mpris-next {
          color: @bone;
          padding: 0 6px;
      }
    '';
    };
  };
}
