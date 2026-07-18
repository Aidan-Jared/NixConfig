
{ self, inputs, ... }: {

  flake.homeModules.remote = { pkgs, lib, ... }: {
    
    home.packages = [
      pkgs.croc
    ];
  };
}
