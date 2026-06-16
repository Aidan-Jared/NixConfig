{ pkgs, lib, ... }:
{

  fonts.fontconfig.enable = true;

  xdg.configFile."cosmic/com.system76.CosmicTerm/v1/config".text = ''
    # Theme: "Dark" | "Light" | "System"
    app_theme = "System"

    # Which built-in or custom color scheme to use in each mode.
    # Built-ins: "COSMIC Dark", "COSMIC Light"
    # Custom schemes are defined separately (see color_schemes_dark below).
    syntax_theme_dark = "COSMIC Dark"
    syntax_theme_light = "COSMIC Light"

    # Font settings
    font_name = "Fira Code"
    font_size = 14
    font_weight = 400       # 400 = Regular
    bold_font_weight = 700  # 700 = Bold
    dim_font_weight = 400
    font_stretch = 5        # 5 = Normal (1=UltraCondensed … 9=UltraExpanded)

    # Ctrl+scroll zoom step (100 = 1.0 pt per tick)
    font_size_zoom_step_mul_100 = 100

    # Background opacity 0–100
    opacity = 95

    # Show the title bar / header bar
    show_headerbar = true

    # Render bold text in bright colours
    use_bright_bold = false

    # In split-pane mode, focus follows the mouse cursor
    focus_follow_mouse = false

    # Profiles and custom colour schemes are managed below as separate files.
    # Leaving these empty uses only the built-in "COSMIC Dark/Light" schemes.
    profiles = {}
    default_profile = ""
    color_schemes_dark = {}
    color_schemes_light = {}
  '';
}
