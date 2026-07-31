{ inputs, ... }: {
  flake.homeModules.vibepanel = { pkgs, lib, ... }: {
    home.packages = [
      inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.default; 

      settings = {
        
      };
    };

  };
}
