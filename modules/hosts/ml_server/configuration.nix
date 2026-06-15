{ self, inputs, ... }:
{

  flake.nixosConfigurations.serverMachine = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.serverConfiguration
    ];
  };

  flake.nixosModules.serverConfiguration = { pkgs, lib, ... }: {

    imports = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.boot
#      self.nixosModules.encrypt
      self.nixosModules.fonts
      self.nixosModules.nixSettings
      self.nixosModules.defaultPkgs
      self.nixosModules.systemConfig
      self.nixosModules.baseHardware
      self.nixosModules.users

      # self.nixosModules.noctalia
      # self.nixosModules.waylandEnv
      
      self.nixosModules.nvidia
      self.nixosModules.nvidiaCuda
      self.nixosModules.tuiGreeter
      # self.nixosModules.noctaliaGreeter
      # self.nixosModules.niri
    ];

    # nixpkgs.overlays = [
    #   inputs.noctalia.overlays.default
    # ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.samantha = self.homeModules.samanthaHome;
    };
  };

}
