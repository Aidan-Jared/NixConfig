{ self, inputs, ... }:
{

  flake.nixosConfigurations.test = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.testConfiguration
    ];
  };

  flake.nixosModules.testConfiguration = { pkgs, lib, ... }: {

    imports = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.lix
      self.nixosModules.boot
      self.nixosModules.fonts
      self.nixosModules.nixSettings
      self.nixosModules.defaultPkgs
      self.nixosModules.systemConfig
      self.nixosModules.testHardware
      self.nixosModules.users
      self.nixosModules.remote
      self.nixosModules.VM
      self.nixosModules.waylandEnv
      
      self.nixosModules.nvidia
      self.nixosModules.nvidiaCuda
      # self.nixosModules.gtkGreeter
      self.nixosModules.tuiGreeter
      # self.nixosModules.nocGreeter
      # self.nixosModules.cosmicGreeter
      self.nixosModules.mango
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.samantha = self.homeModules.samanthaHome;
    };
  };

}
