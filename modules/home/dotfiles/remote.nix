
{ self, inputs, ... }: {

  flake.homeModules.remote = { pkgs, lib, ... }: {
    
    home.packages = [
      pkgs.croc
      pkgs.mosh
      pkgs.tailscale
    ];
    
   	services.tailscale.enable = true;


    programs.mosh.enable = true;
  };
}
