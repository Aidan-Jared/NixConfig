{ self, inputs, ... }:
{
  flake.homeModules.cliTools = { pkgs, lib, ... }: {
   	home.packages = with pkgs; [
      pcmanfm
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
      ripgrep      
      fd           
      jq
      jnv          
      jless
      yazi
      rip2
      atuin
      bat

      # file transfer
      croc

      # Desktop Apps
      tailscale
      ffmpegthumbnailer 
      unar         
      glow  
      poppler
      imagemagick
   	];
   
  };
	
}
