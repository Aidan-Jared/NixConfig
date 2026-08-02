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
                "clock"
            ];
            "modules-right"= [
                "custom/sep"
                "network"
                "temperature"
                "mpris"
                "cpu"
                "memory"
                "custom/power"
            ];

            "mango/workspaces"= {
                format = "{index}";
                on-click = "activate";
                on-click-right = "toggle";
                hide-empty = false;
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
          "mpris"= {
            format= "{player_icon} {artist} - {title}";
            format-paused= "{status_icon} {artist} - {title}";
            on-click= "playerctl play-pause";
            on-click-middle= "playerctl previous";
            on-click-right= "playerctl next";
            player-icons= {
              default= "▶";
              spotify= "󰓇";
              firefox= "󰈹";
              chromium= "";
            };
            "status-icons"= {
              playing= "󰐊";
              paused= "󰏤";
              stopped= "󰓛";
            };
            max-length= 40;
            tooltip-format= "{player} : {artist} - {title}";
            };

          disk = {
              interval= 60;
              path= "/";
              format= "󰋊 {percentage_used}%";
              tooltip-format= "{used} usados de {total}";
          };
        };

          style = ''
            @define-color white      	#F2F2F2;
            @define-color black      	#000000;
            @define-color text       	#FFFFFF;
            @define-color lightgray  	#686868;
            @define-color darkgray   	#353535;

            @define-color transparent	rgba(1, 1, 1, 0.5);
            @define-color teal-trans	rgba(1, 117, 84, 0.5);
            @define-color cyan			rgba(53, 140, 169, 1);

            @define-color background-module     @transparent;
            @define-color border-color          #7F4EA2;
            @define-color color13               #A0536C;

            /* Catppuccin Latte accents (antes em latte.css) */
            @define-color sapphire  #209fb5;
            @define-color mauve     #8839ef;
            @define-color rosewater #dc8a78;
            @define-color sky       #04a5e5;
            @define-color red       #d20f39;
            @define-color yellow    #df8e1d;
            @define-color teal      #179299;

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
                  color: #cba6f7;
              }

              window#waybar.hidden {
                  opacity: 0;
              }

              tooltip {
                  background: #1e1e2e;
                  border-radius: 12px;
                  border-width: 1px;
                  border-style: solid;
                  border-color: @border-color;
                  color: #ffffff;
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
                  color:#FFFFFF;
              }

              #taskbar button {
                  color: #6E6A86;
                  box-shadow: none;
             	text-shadow: none;
                  border-radius: 30px;
                  padding-left: 4px;
                  padding-right: 4px;
                  animation: gradient_f 20s ease-in infinite;
                  transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
              }

              #taskbar button.active {
                  color: #ffd700;
                  border-radius: 50%;
                  background-color: black;
                  border-radius: 15px 15px 15px 15px;
                  padding-left: 8px;
                  padding-right: 8px;
                  animation: gradient_f 20s ease-in infinite;
                  transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
              }

              #taskbar button:hover {
                  color: #ffd700;
                  border-radius: 10px;
               	padding-left: 2px;
                  padding-right: 2px;
                  animation: gradient_f 20s ease-in infinite;
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
                color: #e5d9f5;
               	padding-right: 6px;
               	padding-left: 6px;;
              }

          #temperature.critical {
              background-color: #ff0000;
          }

          @keyframes blink {
              to {
                  color: #000000;
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
              background-color: #22252a;
          }

          #backlight-slider highlight,
          #pulseaudio-slider highlight {
              min-height: 10px;
              border-radius: 5px;
              background-color: #ba5663;
          }

          #pulseaudio-slider,
          #pulseaudio {
         	color: @color13;
          }

          #pulseaudio.muted {
              color: red;
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
         	color: #f53c3c;
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
            color: #efe8f7;
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
            color: #ffd700;}

          /* Tags - ext/workspaces (mangowm) */
        #workspaces button {
            padding: 0 7px;
            color: #cba6f7;
            background: transparent;
            border-radius: 8px;
            font-size: 95%;
            min-width: 22px;
            border-bottom: 2px solid #cba6f7;
            transition: all 0.2s ease;
        }

      #workspaces button.active {
          color: #ffffff;
          background-color: #cba6f7;
          border-radius: 10px;
          padding: 0 10px;
          font-weight: bold;
          border-bottom: none;
      }

      #workspaces button.empty:not(.active) {
          color: #444459;
          border-bottom: none;
      }

      #workspaces button.urgent {
          color: #f38ba8;
          background-color: rgba(243, 56, 56, 0.2);
          border-radius: 8px;
          border-bottom: none;
          animation-name: blink;
          animation-duration: 1s;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #workspaces button:hover {
          color: #ffd700;
          background-color: rgba(255, 215, 0, 0.15);
          border-radius: 8px;
      }

      #custom-sep {
          color: #444459;
          padding: 0 2px;
          font-size: 90%;
      }
      #mpris.paused {
          color: #6c7086;
      }
      #group-mpris-controls {
          background-color: rgba(30, 30, 46, 0.6);
          border-radius: 20px;
          padding: 0 4px;
          margin: 0 4px;
      }

      #custom-mpris-prev,
      #custom-mpris-next {
          color: #cdd6f4;
          padding: 0 6px;
      }
    '';
    };
  };
}
