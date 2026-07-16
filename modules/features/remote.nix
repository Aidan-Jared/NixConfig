
{ self, inputs, ... }: {

  flake.nixosModules.remote = { pkgs, lib, ... }: {
    
    environment.systemPackages = [
      pkgs.tailscale
    ];
    
   	services.tailscale.enable = true;
    services.openssh = {
      enable = true;
      openFirewall = true;
    };

  };
}
