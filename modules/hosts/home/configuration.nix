{ self, inputs, ... }:
{

  flake.nixosConfigurations.homeMachine = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.homeConfiguration
    ];
  };

  flake.nixosModules.homeConfiguration = { pkgs, lib, ... }: {

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
      self.nixosModules.waylandEnv
      
      self.nixosModules.nvidia
      self.nixosModules.nvidiaCuda
      # self.nixosModules.tuiGreeter
      self.nixosModules.noctaliaGreeter
      self.nixosModules.niri
      self.nixosModules.gaming
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
