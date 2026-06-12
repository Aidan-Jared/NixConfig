{ self, inputs, ... }: {
  flake.homeModules.comunication = { pkgs, ... }: {
    home.packages = with pkgs; [
      element-desktop
    ];
  };
}
