{ self, inputs, ... }: {

  flake.nixosModules.remote = { pkgs, lib, ... }: {
    
    services.openssh = {
      enable = true;
      openFirewall = true;
    };
  };
}
