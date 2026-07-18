
{ self, inputs, ... }: {

  flake.nixosModules.remote = { pkgs, lib, ... }: {
    
    environment.systemPackages = [
      pkgs.tailscale
      pkgs.mosh
    ];
    
   	services.tailscale.enable = true;
   	# services.mosh.enable = true;
    services.openssh = {
      enable = true;
      openFirewall = true;
    };

  };
}
