{ self, inputs, ... }:
{

  flake.nixosConfigurations.baseMachine = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.baseConfiguration
    ];
  };

  flake.nixosModules.baseConfiguration = { pkgs, lib, ... }: {

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

      self.nixosModules.niri
      # self.nixosModules.noctalia
      self.nixosModules.waylandEnv
      
      self.nixosModules.nvidia
    ];

    programs.dconf.enable = true;
    programs.niri.enable = true;
    # nixpkgs.overlays = [
    #   inputs.noctalia.overlays.default
    # ];
    environment.loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
        exec niri-session
      fi
    '';    
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.samantha = self.homeModules.samanthaHome;
    };
  };

}
