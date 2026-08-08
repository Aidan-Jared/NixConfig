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
      self.homeModules.shellBash
      self.homeModules.cliTools
      self.homeModules.helix
      # self.homeModules.zellij
      self.homeModules.yazi
      self.homeModules.zen
      self.homeModules.stylix
      # self.homeModules.swaybag
      self.homeModules.extraTools
      self.homeModules.lsp
      self.homeModules.rust
      self.homeModules.python
      self.homeModules.devenv
      self.homeModules.matrix
      self.homeModules.zed
      self.homeModules.jj
      self.homeModules.vscode
      # self.homeModules.wayle
      self.homeModules.noctalia
      # self.homeModules.ewwBar
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
