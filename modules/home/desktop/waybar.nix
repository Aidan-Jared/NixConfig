
{ self, inputs, ... }:
{
  flake.wrappers.waybar = { pkgs, lib, wlib, ... }: {
    
  };

  flake.homeModules.waybar = { pkgs, lib, ... }: {
    home.packages = [
      (self.wrappers.waybar.wrap { inherit pkgs; })
    ];
  };
}
