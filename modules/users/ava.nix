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
      self.homeModules.herdr
      self.homeModules.yazi
      self.homeModules.zen
      self.homeModules.stylix
      self.homeModules.btop
      self.homeModules.starship
      self.homeModules.atuin
      self.homeModules.extraTools
      self.homeModules.git
      self.homeModules.jj
      self.homeModules.lsp
      self.homeModules.rust
      self.homeModules.python
      self.homeModules.devenv
      self.homeModules.comunication
      self.homeModules.zed
      self.homeModules.noctalia
      self.homeModules.remote
      self.homeModules.gaming
      self.homeModules.rLang
    ];

    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nh;
    ]
    
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
    xdg.configFile."mimeapps.list".force = true;
  };
}
