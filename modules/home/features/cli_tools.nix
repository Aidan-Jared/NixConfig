{ self, inputs, ... }:
{
  flake.homeModules.cliTools = { pkgs, lib, ... }: {
   	home.packages = [
      pkgs.xdg-utils
   	  pkgs.fzf

   	  #backup
   	  pkgs.borgbackup

      # Modern Rust CLI Tools
      pkgs.caligula
      pkgs.eza          
      pkgs.xcp
      pkgs.zoxide       
      pkgs.zathura
      pkgs.gitui        
      pkgs.ripgrep-all      
      pkgs.ripgrep
      pkgs.fd        
      pkgs.jq
      pkgs.jnv          
      pkgs.jless
      # yazi
      pkgs.rip2
      pkgs.bat
      pkgs.dust
      pkgs.just

      pkgs.docker
      pkgs.podman
      pkgs.p7zip
      pkgs.gh

      pkgs.zathura
      
      # file transfer
      pkgs.croc

      # Desktop Apps
      pkgs.ffmpegthumbnailer 
      pkgs.unar         
      pkgs.glow  
      pkgs.poppler
      pkgs.imagemagick

      # wrapped

      self.packages.${pkgs.stdenv.hostPlatform.system}.btop
      self.packages.${pkgs.stdenv.hostPlatform.system}.git    
   	];
   programs.gh = {
      enable = true;
      settings = {
         git_protocol = "https";
         prompt = "enabled";
         aliases.co = "pr checkout";
      };
   };
  };
	
}
