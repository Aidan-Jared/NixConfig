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
      gitui        
      ripgrep-all      
      ripgrep
      fd        
      jq
      jnv          
      jless
      # yazi
      rip2
      bat
      dust
      
      p7zip

      # file transfer
      croc

      # Desktop Apps
      ffmpegthumbnailer 
      unar         
      glow  
      poppler
      imagemagick
      swaybg
   	];

   
  };
	
}
