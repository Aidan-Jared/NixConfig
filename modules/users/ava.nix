{ self, inputs, ... }: {
  flake.homeConfigurations.ava = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
        modules = [
          self.homeModules.avaHome
          {
            home.username = "ava";
            home.homeDirectory = "/home/ava";
          }
        ];
  };

  
  flake.homeModules.avaHome = { pkgs, lib, ... }: {
    imports = [
      inputs.stylix.homeModules.stylix
      self.homeModules.shellBash
      self.homeModules.cliTools
      self.homeModules.helix
      self.homeModules.zellij
      self.homeModules.yazi
      self.homeModules.stylix

      # browswer
      self.homeModules.zen

      self.homeModules.extraTools

      # coding
      self.homeModules.git
      self.homeModules.jj
      self.homeModules.lsp
      self.homeModules.rust
      self.homeModules.python
      self.homeModules.rLang
      self.homeModules.devenv
      self.homeModules.matrix
      self.homeModules.discord
      self.homeModules.zed
      self.homeModules.vscode

      # extra
      self.homeModules.remote
      self.homeModules.gaming
    ];

    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nh
    ];
    
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
    xdg.configFile."mimeapps.list".force = true;
  };
}
