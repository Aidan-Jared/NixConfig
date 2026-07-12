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
      zathura
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
      just
      cargo-generate

      docker
      podman
      
      p7zip

      zathura
      # file transfer
      croc

      texlive.combined.scheme-full

      # Desktop Apps
      ffmpegthumbnailer 
      unar         
      glow  
      poppler
      imagemagick
   	];
  };
	
}
