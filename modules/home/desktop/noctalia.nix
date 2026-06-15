{self, inputs, ...}:
{
  flake.homeModules.noctalia = {pkgs, lib, ...}: {
  
    imports = [
      inputs.noctalia.homeModules.default
    ];

      programs.noctalia = {
      enable = true;
      settings = {
        audio = {
          enable_overdrive = true;
          enable_sounds = false;
          notification_sound = "";
          sound_volume = 0.5;
          volume_change_sound = "";
        };

        backdrop = {
          blur_intensity = 0.5;
          enabled = true;
          tint_intensity = 0.30000001192092896;
        };

        bar = {
          order = [ "default" ];
          default = {
            auto_hide = false;
            background_opacity = 0.0;
            border = "outline";
            border_width = 0.0;
            capsule = true;
            capsule_fill = "outline";
            capsule_group = [];
            capsule_opacity = 0.5;
            capsule_padding = 6.0;
            center = [ "date" "clock" "spacer_3" "weather" ];
            contact_shadow = false;
            enabled = true;
            end = [ "clipboard" "network" "bluetooth" "notifications" "battery" "session" ];
            font_weight = 500;
            layer = "top";
            margin_edge = 0;
            margin_ends = 50;
            padding = 14;
            panel_overlap = 1;
            position = "top";
            radius = 21;
            radius_bottom_left = 21;
            radius_bottom_right = 21;
            radius_top_left = 21;
            radius_top_right = 21;
            reserve_space = true;
            scale = 1.0;
            shadow = false;
            start = [ "control-center" "workspaces" ];
            thickness = 34;
            widget_spacing = 6;
          };
        };

        battery = {
          warning_threshold = 20;
        };

        brightness = {
          enable_ddcutil = false;
          ignore_mmids = [];
        };

        calendar = {
          enabled = true;
          refresh_minutes = 15;
        };

        control_center = {
          sidebar = "compact";
          sidebar_section = "compact";
          shortcuts = [
            { type = "wifi"; }
            { type = "bluetooth"; }
            { type = "caffeine"; }
            { type = "nightlight"; }
            { type = "notification"; }
            { type = "power_profile"; }
          ];
        };

        desktop_widgets = {
          enabled = true;
          schema_version = 2;
          widget_order = [
            "desktop-widget-0000000000000001"
            "desktop-widget-0000000000000002"
            "desktop-widget-0000000000000003"
            "desktop-widget-0000000000000004"
            "desktop-widget-0000000000000005"
            "desktop-widget-0000000000000006"
            "desktop-widget-0000000000000007"
            "desktop-widget-0000000000000008"
          ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            # Clock — center top
            "desktop-widget-0000000000000001" = {
              box_height = 336.0;
              box_width = 544.0;
              cx = 960.0;
              cy = 185.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "clock";
              settings = {
                background = false;
                clock_style = "digital";
                shadow = true;
              };
            };
            # Weather — center
            "desktop-widget-0000000000000002" = {
              box_height = 272.0;
              box_width = 448.0;
              cx = 960.0;
              cy = 392.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "weather";
              settings = {
                background = false;
              };
            };
            # Sysmon: net rx/tx — left column
            "desktop-widget-0000000000000003" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 649.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                stat = "net_rx";
                stat2 = "net_tx";
              };
            };
            # Sysmon: ram/gpu_vram — left column
            "desktop-widget-0000000000000004" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 503.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                stat = "ram_pct";
                stat2 = "gpu_vram";
              };
            };
            # Sysmon: gpu_usage/temp — left column
            "desktop-widget-0000000000000005" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 360.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                background_opacity = 0.68000000000000005;
                stat = "gpu_usage";
                stat2 = "gpu_temp";
              };
            };
            # Sysmon: cpu/cpu_temp — left column
            "desktop-widget-0000000000000006" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 217.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                background = true;
                background_color = "surface";
                background_opacity = 0.67000000000000004;
                stat2 = "cpu_temp";
              };
            };
            # Fancy audio visualizer — right
            "desktop-widget-0000000000000007" = {
              box_height = 608.0;
              box_width = 720.0;
              cx = 1552.0;
              cy = 624.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "fancy_audio_visualizer";
              settings = {
                background = false;
                bloom_intensity = 0.0;
                inner_diameter = 1.0;
                rotation_speed = 0.0;
                sensitivity = 3.0;
                visualization_mode = "bars";
              };
            };
            # Media player — right
            "desktop-widget-0000000000000008" = {
              box_height = 112.0;
              box_width = 768.0;
              cx = 1536.0;
              cy = 984.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "media_player";
              settings = {
                background = false;
                hide_when_no_media = true;
                layout = "horizontal";
                shadow = false;
              };
            };
          };
        };

        dock = {
          active_monitor_only = false;
          active_opacity = 1.0;
          active_scale = 1.0;
          auto_hide = false;
          background_opacity = 0.87999999523162842;
          cross_axis_padding = 8;
          enabled = false;
          icon_size = 48;
          inactive_opacity = 0.85000002384185791;
          inactive_scale = 0.85000002384185791;
          item_spacing = 6;
          launcher_icon = "grid-dots";
          launcher_position = "none";
          magnification = true;
          magnification_scale = 1.4500000476837158;
          main_axis_padding = 16;
          margin_edge = 8;
          margin_ends = 0;
          monitors = [];
          pinned = [];
          position = "bottom";
          radius = 16;
          radius_bottom_left = 16;
          radius_bottom_right = 16;
          radius_top_left = 16;
          radius_top_right = 16;
          reserve_space = true;
          shadow = true;
          show_dots = false;
          show_instance_count = true;
          show_running = true;
        };

        hooks = {
          battery_charging = [];
          battery_discharging = [];
          battery_percentage_changed = [];
          battery_plugged = [];
          bluetooth_disabled = [];
          bluetooth_enabled = [];
          colors_changed = [];
          logging_out = [];
          power_profile_changed = [];
          rebooting = [];
          session_locked = [];
          session_unlocked = [];
          shutting_down = [];
          started = [ "ghostty" ];
          theme_mode_changed = [];
          wallpaper_changed = [];
          wifi_disabled = [];
          wifi_enabled = [];
        };

        idle = {
          behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
          pre_action_fade_seconds = 2.0;
          behavior = {
            lock = {
              action = "lock";
              command = "";
              enabled = true;
              resume_command = "";
              timeout = 600;
            };
            "lock-and-suspend" = {
              action = "lock_and_suspend";
              command = "";
              enabled = false;
              resume_command = "";
              timeout = 900;
            };
            "screen-off" = {
              action = "screen_off";
              command = "";
              enabled = true;
              resume_command = "";
              timeout = 660;
            };
          };
        };

        keybinds = {
          cancel = [ "Escape" ];
          down = [ "Down" ];
          left = [ "Left" ];
          right = [ "Right" ];
          up = [ "Up" ];
          validate = [ "Return" "KP_Enter" ];
        };

        location = {
          address = "";
          auto_locate = true;
          sunrise = "";
          sunset = "";
        };

        lockscreen = {
          blur_intensity = 0.0;
          blurred_desktop = false;
          enabled = true;
          fingerprint = false;
          monitors = [];
          tint_intensity = 0.30000001192092896;
          wallpaper = self.wallpaper;
        };

        lockscreen_widgets = {
          enabled = true;
          schema_version = 2;
          widget_order = [
            "lockscreen-widget-0000000000000007"
            "lockscreen-login-box@eDP-1"
            "lockscreen-widget-0000000000000001"
            "lockscreen-widget-0000000000000002"
            "lockscreen-widget-0000000000000003"
            "lockscreen-widget-0000000000000004"
            "lockscreen-widget-0000000000000005"
            "lockscreen-widget-0000000000000006"
            "lockscreen-widget-0000000000000008"
          ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            "lockscreen-login-box@eDP-1" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 960.0;
              cy = 1112.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "login_box";
              settings = {
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12.0;
                input_opacity = 1.0;
                input_radius = 6.0;
                show_login_button = true;
              };
            };
            "lockscreen-widget-0000000000000001" = {
              box_height = 336.0;
              box_width = 544.0;
              cx = 960.0;
              cy = 185.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "clock";
              settings = {
                background = false;
                clock_style = "digital";
                shadow = true;
              };
            };
            "lockscreen-widget-0000000000000002" = {
              box_height = 272.0;
              box_width = 448.0;
              cx = 960.0;
              cy = 392.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "weather";
              settings = {
                background = false;
              };
            };
            "lockscreen-widget-0000000000000003" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 649.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                stat = "net_rx";
                stat2 = "net_tx";
              };
            };
            "lockscreen-widget-0000000000000004" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 503.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                stat = "ram_pct";
                stat2 = "gpu_vram";
              };
            };
            "lockscreen-widget-0000000000000005" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 360.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                background_opacity = 0.68000000000000005;
                stat = "gpu_usage";
                stat2 = "gpu_temp";
              };
            };
            "lockscreen-widget-0000000000000006" = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 140.0;
              cy = 217.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "sysmon";
              settings = {
                background = true;
                background_color = "surface";
                background_opacity = 0.67000000000000004;
                stat2 = "cpu_temp";
              };
            };
            "lockscreen-widget-0000000000000007" = {
              box_height = 608.0;
              box_width = 720.0;
              cx = 1552.0;
              cy = 624.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "fancy_audio_visualizer";
              settings = {
                background = false;
                bloom_intensity = 0.0;
                inner_diameter = 1.0;
                rotation_speed = 0.0;
                sensitivity = 3.0;
                visualization_mode = "bars";
              };
            };
            "lockscreen-widget-0000000000000008" = {
              box_height = 112.0;
              box_width = 768.0;
              cx = 1536.0;
              cy = 984.0;
              enabled = true;
              output = "eDP-1";
              rotation = 0.0;
              type = "media_player";
              settings = {
                background = false;
                hide_when_no_media = true;
                layout = "horizontal";
                shadow = false;
              };
            };
          };
        };

        nightlight = {
          enabled = true;
          force = false;
          temperature_day = 6500;
          temperature_night = 4900;
        };

        notification = {
          allowed_urgencies = [];
          background_opacity = 0.97000002861022949;
          blacklist = [];
          blacklist_allow_critical = true;
          collapse_on_dismiss = true;
          enable_daemon = true;
          layer = "top";
          monitors = [];
          offset_x = 20;
          offset_y = 8;
          position = "top_right";
          scale = 1.0;
          show_actions = true;
          show_app_name = true;
        };

        osd = {
          background_opacity = 0.97000002861022949;
          monitors = [];
          offset_x = 20;
          offset_y = 8;
          orientation = "horizontal";
          position = "top_center";
          scale = 1.0;
          kinds = {
            bluetooth = true;
            brightness = true;
            caffeine = true;
            dnd = true;
            keyboard_layout = true;
            lock_keys = true;
            power_profile = true;
            volume = true;
            volume_input = true;
            volume_output = true;
            wifi = true;
          };
        };

        plugins = {
          enabled = [];
          source = [
            {
              auto_update = false;
              enabled = true;
              kind = "git";
              location = "https://github.com/noctalia-dev/official-plugins";
              name = "official";
            }
            {
              auto_update = false;
              enabled = true;
              kind = "git";
              location = "https://github.com/noctalia-dev/community-plugins";
              name = "community";
            }
          ];
        };

        shell = {
          app_icon_colorize = false;
          avatar_path = "";
          clipboard_auto_paste = "auto";
          clipboard_confirm_clear_history = true;
          clipboard_enabled = true;
          clipboard_history_max_entries = 100;
          clipboard_image_action_command = "";
          corner_radius_scale = 2.0;
          date_format = "%A, %x";
          disable_mipmaps = false;
          font_family = "FiraCode Nerd Font Mono";
          lang = "en";
          launch_apps_as_systemd_services = false;
          middle_click_opens_widget_settings = true;
          niri_overview_type_to_launch_enabled = false;
          offline_mode = false;
          password_style = "random";
          polkit_agent = true;
          screen_time_enabled = false;
          settings_show_advanced = true;
          setup_wizard_enabled = true;
          shared_gl_context = true;
          show_location = true;
          telemetry_enabled = false;
          time_format = "{:%H:%M:%S}";
          ui_scale = 0.89999997615814209;
          animation = {
            enabled = true;
            speed = 1.0;
          };
          mpris = {
            blacklist = [];
          };
          panel = {
            borders = true;
            clipboard_placement = "centered";
            control_center_placement = "attached";
            launcher_categories = true;
            launcher_compact = true;
            launcher_placement = "centered";
            launcher_session_search = false;
            launcher_show_icons = true;
            open_near_click_clipboard = false;
            open_near_click_control_center = false;
            open_near_click_launcher = false;
            open_near_click_session = false;
            open_near_click_wallpaper = false;
            session_placement = "attached";
            shadow = true;
            transparency_mode = "soft";
            wallpaper_placement = "attached";
          };
          screen_corners = {
            enabled = true;
            size = 47;
          };
          screenshot = {
            copy_to_clipboard = true;
            directory = "";
            filename_pattern = "";
            freeze_screen = true;
            pipe_command = "";
            pipe_to_command = false;
            save_to_file = true;
          };
          session = {
            actions = [
              {
                action = "lock";
                command = "";
                enabled = true;
                glyph = "";
                label = "";
                shortcut = "1";
                variant = "default";
              }
              {
                action = "logout";
                command = "";
                enabled = true;
                glyph = "";
                label = "";
                shortcut = "2";
                variant = "default";
              }
              {
                action = "lock_and_suspend";
                command = "";
                enabled = true;
                glyph = "";
                label = "";
                shortcut = "3";
                variant = "default";
              }
              {
                action = "reboot";
                command = "";
                enabled = true;
                glyph = "";
                label = "";
                shortcut = "4";
                variant = "default";
              }
              {
                action = "shutdown";
                command = "";
                enabled = true;
                glyph = "";
                label = "";
                shortcut = "5";
                variant = "destructive";
              }
            ];
          };
          shadow = {
            alpha = 0.55000001192092896;
            direction = "down";
          };
        };

        "system.monitor" = {
          cpu_poll_seconds = 2.0;
          cpu_temp_activity_threshold = 60.0;
          cpu_temp_critical_threshold = 85.0;
          cpu_temp_sensor_path = "";
          cpu_usage_activity_threshold = 50.0;
          cpu_usage_critical_threshold = 90.0;
          disk_pct_activity_threshold = 80.0;
          disk_pct_critical_threshold = 95.0;
          disk_poll_seconds = 10.0;
          enabled = true;
          gpu_poll_seconds = 2.0;
          gpu_temp_activity_threshold = 60.0;
          gpu_temp_critical_threshold = 85.0;
          gpu_usage_activity_threshold = 50.0;
          gpu_usage_critical_threshold = 95.0;
          gpu_vram_activity_threshold = 50.0;
          gpu_vram_critical_threshold = 90.0;
          memory_poll_seconds = 2.0;
          net_rx_activity_threshold = 1.0;
          net_rx_critical_threshold = 50.0;
          net_tx_activity_threshold = 1.0;
          net_tx_critical_threshold = 50.0;
          network_poll_seconds = 3.0;
          ram_pct_activity_threshold = 60.0;
          ram_pct_critical_threshold = 90.0;
          swap_pct_activity_threshold = 20.0;
          swap_pct_critical_threshold = 80.0;
        };

        theme = {
          builtin = "Noctalia";
          community_palette = "Oxocarbon";
          custom_palette = "";
          mode = "dark";
          source = "wallpaper";
          wallpaper_scheme = "m3-content";
          templates = {
            builtin_ids = [];
            community_ids = [];
            enable_builtin_templates = true;
            enable_community_templates = true;
          };
        };

        wallpaper = {
          directory = "";
          directory_dark = "";
          directory_light = "";
          edge_smoothness = 0.30000001192092896;
          enabled = true;
          fill_color = "";
          fill_mode = "crop";
          per_monitor_directories = false;
          transition = [ "fade" "wipe" "disc" "stripes" "zoom" "honeycomb" ];
          transition_duration = 1500.0;
          transition_on_startup = false;
          automation = {
            enabled = false;
            interval_seconds = 1800;
            order = "random";
            recursive = true;
          };
        };

        weather = {
          effects = true;
          enabled = true;
          refresh_minutes = 30;
          unit = "metric";
        };

        "widget.active_window" = {
          icon_size = 14.0;
          max_length = 260.0;
          min_length = 80.0;
          title_scroll = "none";
          type = "active_window";
        };

        "widget.audio_visualizer" = {
          type = "audio_visualizer";
          width = 8.0;
        };

        "widget.cat" = {
          type = "noctalia/bongocat:cat";
        };

        "widget.clock" = {
          anchor = true;
          capsule = true;
          capsule_fill = "outline";
          capsule_opacity = 0.5;
          format = "{:%H:%M:%S}";
          type = "clock";
        };

        "widget.control-center" = {
          capsule = true;
          capsule_fill = "outline";
          capsule_opacity = 0.5;
          glyph = "brand-snowflake";
          type = "control-center";
        };

        "widget.cpu" = {
          stat = "cpu_usage";
          type = "sysmon";
        };

        "widget.date" = {
          format = "{:%a %d %b}";
          type = "clock";
        };

        "widget.input_volume" = {
          device = "input";
          type = "volume";
        };

        "widget.keyboard_layout" = {
          cycle_command = "";
          hide_when_single_layout = false;
          type = "keyboard_layout";
        };

        "widget.lock_keys" = {
          display = "short";
          hide_when_off = false;
          show_caps_lock = true;
          show_num_lock = true;
          show_scroll_lock = false;
          type = "lock_keys";
        };

        "widget.media" = {
          art_size = 16.0;
          max_length = 220.0;
          min_length = 80.0;
          title_scroll = "none";
          type = "media";
        };

        "widget.network_rx" = {
          stat = "net_rx";
          type = "sysmon";
        };

        "widget.network_tx" = {
          stat = "net_tx";
          type = "sysmon";
        };

        "widget.output_volume" = {
          device = "output";
          type = "volume";
        };

        "widget.ram" = {
          stat = "ram_used";
          type = "sysmon";
        };

        "widget.spacer" = {
          type = "spacer";
        };

        "widget.spacer_2" = {
          type = "spacer";
        };

        "widget.spacer_3" = {
          length = 10;
          type = "spacer";
        };

        "widget.temp" = {
          stat = "cpu_temp";
          type = "sysmon";
        };

        "widget.weather" = {
          capsule = true;
          capsule_fill = "outline";
          capsule_opacity = 0.5;
          type = "weather";
        };

        "widget.workspaces" = {
          capsule = true;
          capsule_fill = "outline";
          capsule_opacity = 0.5;
          labels_only_when_occupied = true;
          type = "workspaces";
        };
      };
    };
  };
}
