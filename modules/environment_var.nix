{ ... }:
{
 environment.sessionVariables = {
   NIXOS_OZONE_WL = "1";  # Electron / Chromium Wayland backend
    MOZ_ENABLE_WAYLAND = "1";  # Firefox
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # XDG session
    # XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "niri";
    # XDG_SESSION_TYPE = "wayland";
    # XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "niri";

    # Nvidia-specific
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # GBM_BACKEND = "nvidia-drm"; # remove if black screen on launch
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";

    # Nvidia cursor fix (hardware cursor broken on many driver versions)
    WLR_NO_HARDWARE_CURSORS = "1";
 };
}
