{ ... }:
{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.power-profiles-daemon.enable = true;

  services.upower.enable = true;

  services.printing.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  programs.firefox.enable = true;
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
  
}
