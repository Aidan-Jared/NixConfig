{ inputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.flakeModules.default
  ];

  environment.systemPackages = [ pkgs.pcmanfm pkgs.xdg-utils ];
}
