
{ self, inputs, ... }: {

  flake.nixosModules.remote = { pkgs, lib, ... }: {
    
    environment.systemPackages = [
      pkgs.mosh
    ];
    
    services.openssh = {
      enable = true;
      openFirewall = true;
    };

    programs.mosh.enable = true;
  };
}
