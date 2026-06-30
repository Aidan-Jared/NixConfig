{ inputs, self, ... }: {

  flake.homeModules.sops = { pkgs, ... }: {

    home.packages = [
      inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    xdg.configFile."herdr/config.toml".text = builtins.readFile ./config.toml;
 };
}
