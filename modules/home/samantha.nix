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
      inputs.niri.homeModules.niri
      inputs.noctalia.homeModules.default
      inputs.stylix.homeModules.stylix
      self.homeModules.shellBash
      self.homeModules.cliTools
      self.homeModules.helix
      self.homeModules.zellij
      self.homeModules.yazi
      self.homeModules.zen
      self.homeModules.stylix
      self.homeModules.niri
      self.homeModules.noctalia
      self.homeModules.btop
      self.homeModules.starship
      self.homeModules.ghostty
      self.homeModules.git
      self.homeModules.lsp
      self.homeModules.rust
      self.homeModules.python
      self.homeModules.comunication
      self.homeModules.zed
    ];
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
  };
}
