{ pkgs, ... }:
{
  home.packages =[
    #github
    pkgs.gh
  ];
  
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name ="Aidan-Jared";
      user.email = "AidanJared42@gmail.com";
    };
  };

   programs.gh.enable = true;
   programs.gh.settings = {
     git_protocol = "ssh";
     prompt = "enabled";
     aliases.co = "pr checkout";
   };
}
