{self, inputs, ...}:
{
  flake.homeModules.stasis = {pkgs, lib, ...}: {
  
    imports = [
     	inputs.stasis.homeManagerModules.default
    ];
  };

  flake.nixosModules.gtlock = { pkgs, lib, config, ... }: {

    programs.gtklock = {
      enable = true;
      package = pkgs.gtklock;
      config = {
        main = {
          idle-hide = true;
          idle-timeout = 10;
        };
      };
      style = ''
        window {
          background-color: rgba(0, 0, 0, 0.8);
        }
      '';
      modules = with pkgs; [
        gtklock-playerctl-module
        gtklock-powerbar-module
      ];
    };

    security.pam.services.gtklock = {};
  };
}
