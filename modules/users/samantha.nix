{ self, inputs, ... }: {
  flake.homeConfigurations.samantha = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
        modules = [
          self.homeModules.samanthaHome
          {
            home.username = "samantha";
            home.homeDirectory = "/home/samantha";
          }
        ];
  };

  
  flake.homeModules.samanthaHome = { pkgs, lib, ... }: {
    imports = [
      # inputs.stylix.homeModules.stylix
      # cli
      self.homeModules.shellBash
      self.homeModules.cliTools
      self.homeModules.helix
      self.homeModules.zellij
      self.homeModules.yazi
      self.homeModules.lsp
      self.homeModules.jj

      # coding
      self.homeModules.rust
      self.homeModules.python
      self.homeModules.devenv
      self.homeModules.vscode
      self.homeModules.zed
      
      # desktop
      self.homeModules.extraTools
      self.homeModules.zen
      self.homeModules.matrix

      # ricing
      self.homeModules.stylix
      self.homeModules.waybar
      # self.homeModules.noctalia
      # self.homeModules.vicinae
    ];

    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nh
    ];

    services.awww = {
      enable = true;
    };

    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
    xdg.configFile."mimeapps.list".force = true;
  };
}
