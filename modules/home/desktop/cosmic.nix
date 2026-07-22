
{self, inputs, ...}:
{
  flake.nixosModules.cosmic = {pkgs, lib, ...}: {
    # Enable the COSMIC desktop environment
    services.desktopManager.cosmic.enable = true;
    services.system76-scheduler.enable = true;
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
    home.packages = [
      pkgs.swaybg
    ];
  };

  flake.nixosModules.cosmicGreeter = { pkgs, lib, ... }: {
    services.displayManager.cosmic-greeter.enable = true;
  };
}
