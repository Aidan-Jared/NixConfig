{ ... }:
{
    services.xserver.enable = true;
    services.system76-scheduler.enable = true;
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  # cosmic branch
    services.displayManager.cosmic-greeter.enable = true;
    services.displayManager.autoLogin = {
      enable = true;
      user = "samantha";
    };
    services.desktopManager.cosmic.enable = true;
}
