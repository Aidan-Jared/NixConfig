{ inputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.flakeModules.default
  ];
}
