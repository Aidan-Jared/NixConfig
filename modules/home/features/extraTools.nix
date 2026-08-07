
{ self, inputs, ... }:
{
  flake.homeModules.extraTools = { pkgs, lib, ... }: {
   	home.packages = with pkgs; [
   	   spotify
   	   obsidian
   	   zotero
   	   transmission_4 
   	   proton-vpn
   	];
  };
	
}
