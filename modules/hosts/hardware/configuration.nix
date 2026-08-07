{ self, inputs, ... }:
{

  flake.nixosConfigurations.hardwareMachine = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.hardwareConfiguration
    ];
  };

  flake.nixosModules.hardwareConfiguration = { pkgs, lib, ... }: {

    imports = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.lix
      self.nixosModules.boot
#      self.nixosModules.encrypt
      self.nixosModules.fonts
      self.nixosModules.nixSettings
      self.nixosModules.defaultPkgs
      self.nixosModules.systemConfig
      self.nixosModules.cudaHardware
      self.nixosModules.users
      self.nixosModules.remote
      self.nixosModules.VM
      self.nixosModules.waylandEnv
      
      self.nixosModules.nvidia
      self.nixosModules.nvidiaCuda
      # self.nixosModules.gtkGreeter
      # self.nixosModules.tuiGreeter
      self.nixosModules.nocGreeter
      # self.nixosModules.cosmicGreeter
      # self.nixosModules.niri
      self.nixosModules.mango
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

    fileSystems = {
      "/".options = [ "compress=zstd" ];
      "/home".options = [ "compress=zstd" ];
      "/nix".options = [ "compress=zstd" "noatime" ];
      "/swap".options = [ "noatime" ];
    };
    services.beesd.filesystems = {
      root = {
        spec = "LABEL=root";
        hashTableSizeMB = 2048;
        verbosity = "crit";
        extraOptions = [ "--loadavg-target" "5.0" ];
      };
    };
  };
}
