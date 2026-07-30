
{ self, inputs, ... }:
{

  flake.nixosConfigurations.avaFull = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.avaConfiguration
    ];
  };

  flake.nixosModules.avaConfiguration = { pkgs, lib, ... }: {

    nixpkgs.config.allowUnfree = true;
    imports = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.lix
      self.nixosModules.fonts
      self.nixosModules.nixSettings
      self.nixosModules.defaultPkgs
      self.nixosModules.remote
      self.nixosModules.VM
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.ava = self.homeModules.avaHome;
    };
  };

}
