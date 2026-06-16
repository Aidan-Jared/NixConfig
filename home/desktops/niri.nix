
{ inputs, pkgs, config, lib, ... }:
{

  imports = [
    # ./bars/eww.nix
    inputs.niri.homeModules.niri
    # ./stylix.nix
    # ./walker.nix
    ./noctalia.nix
  ];

  home.packages = with pkgs; [
    # Hyprland ecosystem
    # awww       # wallpaper daemon
    wlogout

    # Bar
    # wayle
    # waybar
    # eww
    # jq

    # Launcher
    # rofi

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
    # pamixer        # audio control for waybar/keybinds
    playerctl      # media keys
    networkmanagerapplet
  ]; 
  
  programs.niri = {
    enable = true;
    settings = {
      outputs."*".scale = 1.0;

      environment = {
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm";
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
      };

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          natural-scroll = false;
          tap = true;
        };
      };

      layout = {
        gaps = 10;
        border = {
          enable = true;
          width = 2;
          # active-color = "#33ccffee";
          # inactive-color = "#595959aa";
        };
      };

      spawn-at-startup = [
        { command = [ "noctalia" ]; }
        # { command = [ "${pkgs.mako}/bin/mako" ]; }
        # { command = [ "${pkgs.awww}/bin/awww-daemon" ]; }
        { command = [ "${pkgs.networkmanagerapplet}/bin/nm-applet" "--indicator" ]; }
        { command = [ "${pkgs.wl-clipboard}/bin/wl-paste" "--type" "text" "--watch" "${pkgs.cliphist}/bin/cliphist" "store" ]; }
        { command = [ "${pkgs.wl-clipboard}/bin/wl-paste" "--type" "image" "--watch" "${pkgs.cliphist}/bin/cliphist" "store" ]; }
      ];

      binds = {
        "Super+T".action.spawn = "${pkgs.ghostty}/bin/ghostty";
        # "Super+A".action.spawn = "${pkgs.rofi-wayland}/bin/rofi" "-show" "drun";

        "Super+A".action.spawn = "noctalia msg panel-toggle launcher";
        "Super+S".action.spawn = "noctalia msg panel-toggle control-center";
        "Super+Comma".action.spawn = "noctalia msg settings-toggle";
        "Super+E".action.spawn = "${pkgs.yazi}/bin/yazi";
        "Super+Q".action.close-window = {};
        "Super+Shift+E".action.quit = {};
        "Super+F".action.maximize-column = {};
        "Super+Shift+F".action.fullscreen-window = {};
        "Super+V".action.toggle-window-floating = {};
        "Super+Shift+Q".action.spawn = "${pkgs.wlogout}/bin/wlogout";

        "Super+Left".action.focus-column-left = {};
        "Super+Right".action.focus-column-right = {};
        "Super+Up".action.focus-window-up = {};
        "Super+Down".action.focus-window-down = {};
        "Super+H".action.focus-column-left = {};
        "Super+L".action.focus-column-right = {};
        "Super+K".action.focus-window-up = {};
        "Super+J".action.focus-window-down = {};

        "Super+Shift+Left".action.move-column-left = {};
        "Super+Shift+Right".action.move-column-right = {};
        "Super+Shift+H".action.move-column-left = {};
        "Super+Shift+L".action.move-column-right = {};

        "Super+1".action.focus-workspace = 1;
        "Super+2".action.focus-workspace = 2;
        "Super+3".action.focus-workspace = 3;
        "Super+4".action.focus-workspace = 4;
        "Super+5".action.focus-workspace = 5;

        "Super+Shift+1".action.move-window-to-workspace = 1;
        "Super+Shift+2".action.move-window-to-workspace = 2;
        "Super+Shift+3".action.move-window-to-workspace = 3;
        "Super+Shift+4".action.move-window-to-workspace = 4;
        "Super+Shift+5".action.move-window-to-workspace = 5;

        "Print".action.screenshot = {};
        "Shift+Print".action.screenshot-screen = {};
        "Super+Print".action.screenshot-window = {};

        "Super+Escape".action.spawn = "${pkgs.swaylock}/bin/swaylock";

        "XF86AudioRaiseVolume".action.spawn = "noctalia msg volume-up";
        "XF86AudioLowerVolume".action.spawn = "noctalia msg volume-down";
        "XF86AudioMute".action.spawn = "noctalia msg volume-mute";
        "XF86MonBrightnessUp".action.spawn = "noctalia msg brightness-up";
        "XF86MonBrightnessDown".action.spawn = "noctalia msg brightness-down";
        "XF86AudioPlay".action.spawn = "${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext".action.spawn = "${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev".action.spawn = "${pkgs.playerctl}/bin/playerctl previous";
      };
    };
  };


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


  # ── GTK theming ───────────────────────────────────────────────────────────
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name    = "adw-gtk3-dark";
  #     package = pkgs.adw-gtk3;
  #   };
  #   iconTheme = {
  #     name    = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   cursorTheme = {
  #     name    = "Adwaita";
  #     package = pkgs.adwaita-icon-theme;
  #     size    = 24;
  #   };
  # };

  # Tell GTK4 / libadwaita to use dark
  # dconf.settings."org/gnome/desktop/interface" = {
  #   color-scheme = "prefer-dark";
  #   cursor-theme = "Adwaita";
  #   cursor-size  = 24;
  # };

  # ── Qt theming ────────────────────────────────────────────────────────────
  # qt = {
  #   enable         = true;
  #   platformTheme.name  = "gtk";
  #   style.name     = "adwaita-dark";
  # };

  # ── Rofi ──────────────────────────────────────────────────────────────────
  # programs.rofi = {
  #   enable   = true;
  #   package  = pkgs.rofi;
  #   terminal = "${pkgs.ghostty}/bin/ghostty";
  #   theme    = "catppuccin-mocha"; # requires the theme file below
  #   extraConfig = {
  #     modi            = "drun,run,window";
  #     show-icons      = true;
  #     drun-display-format = "{name}";
  #   };
  # };

  # # Catppuccin Mocha theme for rofi
  # xdg.configFile."rofi/catppuccin-mocha.rasi".text = ''
  #   * {
  #     bg:      #1e1e2e;
  #     bg-alt:  #313244;
  #     fg:      #cdd6f4;
  #     accent:  #89b4fa;
  #     urgent:  #f38ba8;
  #     background-color: @bg;
  #     text-color:       @fg;
  #     border-color:     @accent;
  #   }

  #   window   { border: 2; padding: 5; }
  #   inputbar { children: [prompt, entry]; background-color: @bg-alt; padding: 6; }
  #   prompt   { text-color: @accent; }
  #   listview { lines: 8; padding: 4; }
  #   element  { padding: 6; }
  #   element selected { background-color: @accent; text-color: @bg; }
  # '';
}
