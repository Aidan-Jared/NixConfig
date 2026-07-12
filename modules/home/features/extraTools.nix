
{ self, inputs, ... }:
{
  flake.homeModules.extraTools = { pkgs, lib, ... }: {
   	home.packages = with pkgs; [
   	   typst
   	   taplo

   	   spotify
   	   obsidian
   	   zotero

   	   transmission 
   	];
  };
	
}
