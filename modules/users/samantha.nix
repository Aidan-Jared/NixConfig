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
      inputs.stylix.homeModules.stylix
      self.homeModules.shellBash
      self.homeModules.cliTools
      self.homeModules.helix
      self.homeModules.zellij
      self.homeModules.yazi
      self.homeModules.zen
      self.homeModules.stylix
      self.homeModules.btop
      self.homeModules.starship
      self.homeModules.atuin
      self.homeModules.ghostty
      self.homeModules.git
      self.homeModules.lsp
      self.homeModules.rust
      self.homeModules.python
      self.homeModules.devenv
      self.homeModules.comunication
      self.homeModules.zed
      self.homeModules.noctalia
      self.homeModules.ewwBar
    ];
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
    xdg.configFile."mimeapps.list".force = true;
  };
}
