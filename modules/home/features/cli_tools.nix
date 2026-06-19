{ self, inputs, ... }:
{
  flake.homeModules.cliTools = { pkgs, lib, ... }: {
   	home.packages = with pkgs; [
      xdg-utils
   	  
   	  fzf

   	  #backup
   	  borgbackup

      # Modern Rust CLI Tools
      caligula
      eza          
      xcp
      zoxide       
      zellij       
      gitui        
      ripgrep-all      
      ripgrep
      fd        
      jq
      jnv          
      jless
      # yazi
      rip2
      atuin
      bat
      dust
      
      p7zip

      # file transfer
      croc

      # Desktop Apps
      # tailscale
      ffmpegthumbnailer 
      unar         
      glow  
      poppler
      imagemagick
      swaybg
   	];

   
  };
	
}
