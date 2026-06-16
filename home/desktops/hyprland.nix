{ inputs, pkgs, ... }:
{

  home.packages = with pkgs; [
    # Hyprland ecosystem
    hyprpaper       # wallpaper daemon
    hyprlock        # screen locker
    hypridle        # idle management
    hyprshot        # screenshots
    wlogout

    # Bar
    wayle

    # Launcher
    rofi

    # Notifications
    mako

    # Clipboard
    wl-clipboard
    cliphist

    # Terminal
    ghostty

    # File manager
    # nautilus

    # Theming
    nwg-look  # GTK settings GUI for Wayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct

    # Utilities
    brightnessctl  # backlight control
    pamixer        # audio control for waybar/keybinds
    playerctl      # media keys
    networkmanagerapplet
  ]; 
  
  wayland.windowManager.hyprland = {
    enable = true;
    # withUWSM = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {
      # ── Monitor ────────────────────────────────────────────────────────
      # Replace with your actual output, e.g. "DP-1,2560x1440@144,0x0,1"
      monitor = ",preferred,auto,1";

      # ── Nvidia env vars (set here too so Hyprland's own process gets them)
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"       # remove this line if you get a black screen
        "WLR_NO_HARDWARE_CURSORS,1"
        "NIXOS_OZONE_WL,1"
        "MOZ_ENABLE_WAYLAND,1"
        "QT_QPA_PLATFORM,wayland;xcb"
      ];

      # ── Autostart ──────────────────────────────────────────────────────
      "exec-once" = [
        "${pkgs.mako}/bin/mako"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.wayle}/bin/wayle"
        "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
        # Clipboard history manager
        "${pkgs.wl-clipboard}/bin/wl-paste --type text  --watch ${pkgs.cliphist}/bin/cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
      ];

      # ── Input ──────────────────────────────────────────────────────────
      input = {
        kb_layout     = "us";
        follow_mouse  = 1;
        sensitivity   = 0;
        touchpad = {
          natural_scroll   = false;
          disable_while_typing = true;
        };
      };

      # ── General ────────────────────────────────────────────────────────
      general = {
        gaps_in   = 5;
        gaps_out  = 10;
        border_size = 2;
        "col.active_border"   = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "scrolling";
      };

      # ── Decoration ─────────────────────────────────────────────────────
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size    = 8;
          passes  = 2;
        };
        # drop_shadow  = true;
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };

      # ── Animations ─────────────────────────────────────────────────────
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows,    1, 7,  myBezier"
          "windowsOut, 1, 7,  default, popin 80%"
          "border,     1, 10, default"
          "borderangle,1, 8,  default"
          "fade,       1, 7,  default"
          "workspaces, 1, 6,  default"
        ];
      };

      # ── Layouts ────────────────────────────────────────────────────────
      dwindle = {
        pseudotile     = true;
        preserve_split = true;
      };

      # master = {
      #   new_is_master = true;
      # };

      # ── Cursor (Nvidia fix) ────────────────────────────────────────────
      cursor = {
        no_hardware_cursors = true;
      };

      # ── Misc ───────────────────────────────────────────────────────────
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo   = true;
      };

      # ── Keybinds ───────────────────────────────────────────────────────
      "$mod"      = "SUPER";
      "$terminal" = "${pkgs.ghostty}/bin/ghostty";
      "$launcher" = "${pkgs.rofi}/bin/rofi -show drun";
      "$files"    = "${pkgs.yazi}/bin/yazi";

      bind = [
        # Core
        "$mod, T, exec, $terminal"
        "$mod, A,      exec, $launcher"
        "$mod, E,      exec, $files"
        "$mod, Q,      killactive"
        "$mod SHIFT, E, exit"
        "$mod, F,      fullscreen"
        "$mod, V,      togglefloating"
        "$mod, P,      pseudo"
        "$mod, S,      togglesplit"
        "$mod SHIFT, Q, exec, ${pkgs.wlogout}/bin/wlogout"

        # Focus movement
        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"
        "$mod, h,     movefocus, l"
        "$mod, l,     movefocus, r"
        "$mod, k,     movefocus, u"
        "$mod, j,     movefocus, d"

        # Move windows
        "$mod SHIFT, left,  movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up,    movewindow, u"
        "$mod SHIFT, down,  movewindow, d"
        "$mod SHIFT, h,  movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k,    movewindow, u"
        "$mod SHIFT, j,  movewindow, d"

        # Workspaces 1–9
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # Move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up,   workspace, e-1"

        # Screenshots
        ", Print,       exec, ${pkgs.hyprshot}/bin/hyprshot -m output"
        "SHIFT, Print,  exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
        "$mod, Print,   exec, ${pkgs.hyprshot}/bin/hyprshot -m window"

        # Clipboard history
        "$mod, C, exec, ${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi}/bin/rofi -dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"

        # Screen lock
        "$mod, Esc, exec, ${pkgs.hyprlock}/bin/hyprlock"
      ];

      # Media / brightness keys (no repeat needed — use bindel for held keys)
      bindel = [
        ", XF86AudioRaiseVolume,  exec, ${pkgs.pamixer}/bin/pamixer -i 5"
        ", XF86AudioLowerVolume,  exec, ${pkgs.pamixer}/bin/pamixer -d 5"
        ", XF86MonBrightnessUp,   exec, ${pkgs.brightnessctl}/bin/brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
      ];

      bindl = [
        ", XF86AudioMute,        exec, ${pkgs.pamixer}/bin/pamixer -t"
        ", XF86AudioPlay,        exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext,        exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev,        exec, ${pkgs.playerctl}/bin/playerctl previous"
      ];

      # Mouse binds
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"                        # prevent apps maximizing themselves
        "float, class:^(yazi)$, title:^(File Operation.*)$"  # nautilus dialogs float
        "float, class:^(nm-connection-editor)$"
        "float, class:^(org.gnome.polkit-gnome-authentication-agent-1)$"
        "idleinhibit focus, class:^(mpv)$"                       # no idle while watching video
      ];
    };
  };
 # ── Hyprpaper ─────────────────────────────────────────────────────────────
  # Place a wallpaper at ~/wallpaper.png or adjust the path below
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/wallpaper.png
    wallpaper = ,~/wallpaper.png
    splash = false
  '';

  # ── Hyprlock ──────────────────────────────────────────────────────────────
  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ~/wallpaper.png
      blur_passes = 3
      blur_size    = 8
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 2
      dots_size         = 0.33
      dots_spacing      = 0.15
      fade_on_empty     = true
      placeholder_text  = <i>Password...</i>
      halign = center
      valign = center
    }

    label {
      monitor =
      text    = cmd[update:1000] echo "<b>$(date +"%H:%M")</b>"
      font_size = 64
      halign    = center
      valign    = top
      position  = 0, -100
    }
  '';

  # ── Hypridle ──────────────────────────────────────────────────────────────
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd         = pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd  = hyprctl dispatch dpms on
    }

    listener {
      timeout  = 300  # 5 min: dim screen
      on-timeout  = ${pkgs.brightnessctl}/bin/brightnessctl -s s 10%
      on-resume   = ${pkgs.brightnessctl}/bin/brightnessctl -r
    }

    listener {
      timeout  = 600  # 10 min: lock
      on-timeout = loginctl lock-session
    }

    listener {
      timeout  = 1200  # 20 min: suspend
      on-timeout = systemctl suspend
    }
  '';

  # ── Mako (notifications) ──────────────────────────────────────────────────
  services.mako = {
    enable          = true;
    settings = {
      defaultTimeout  = 5000;
      anchor          = "top-right";
      borderRadius    = 8;
      backgroundColor = "#1e1e2eee";
      textColor       = "#cdd6f4";
      borderColor     = "#89b4fa";
    };
  };

  # ── Waybar ────────────────────────────────────────────────────────────────
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer  = "top";
        position = "top";
        height = 32;
        modules-left   = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right  = [
          "pulseaudio"
          "network"
          "battery"
          "cpu"
          "memory"
          "tray"
        ];

        "hyprland/workspaces" = {
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

  # ── GTK theming ───────────────────────────────────────────────────────────
  gtk = {
    enable = true;
    theme = {
      name    = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name    = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size    = 24;
    };
  };

  # Tell GTK4 / libadwaita to use dark
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    cursor-theme = "Adwaita";
    cursor-size  = 24;
  };

  # ── Qt theming ────────────────────────────────────────────────────────────
  qt = {
    enable         = true;
    platformTheme.name  = "gtk";
    style.name     = "adwaita-dark";
  };

  # ── Rofi ──────────────────────────────────────────────────────────────────
  programs.rofi = {
    enable   = true;
    package  = pkgs.rofi;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    theme    = "catppuccin-mocha"; # requires the theme file below
    extraConfig = {
      modi            = "drun,run,window";
      show-icons      = true;
      drun-display-format = "{name}";
    };
  };

  # Catppuccin Mocha theme for rofi
  xdg.configFile."rofi/catppuccin-mocha.rasi".text = ''
    * {
      bg:      #1e1e2e;
      bg-alt:  #313244;
      fg:      #cdd6f4;
      accent:  #89b4fa;
      urgent:  #f38ba8;
      background-color: @bg;
      text-color:       @fg;
      border-color:     @accent;
    }

    window   { border: 2; padding: 5; }
    inputbar { children: [prompt, entry]; background-color: @bg-alt; padding: 6; }
    prompt   { text-color: @accent; }
    listview { lines: 8; padding: 4; }
    element  { padding: 6; }
    element selected { background-color: @accent; text-color: @bg; }
  '';
}
