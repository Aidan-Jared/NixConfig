{ self, inputs, ... }: {
  flake.homeConfigurations.ajar667 = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
        modules = [
          self.homeModules.ajar667Home
          {
            home.username = "ajar667";
            home.homeDirectory = "/home/ajar667";
          }
        ];
  };

  
  flake.homeModules.ajar667Home = { pkgs, lib, ... }: {
    imports = [
      self.homeModules.shellBash
      self.homeModules.cliTools
      self.homeModules.helix
      self.homeModules.zellij
      # self.homeModules.starship
      self.homeModules.atuin
      self.homeModules.devenv
      self.homeModules.remote
    ];
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    # xdg.configFile."mimeapps.list".force = true;
  };
}
