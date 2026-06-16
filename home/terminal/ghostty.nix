{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      # font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      # theme = "catppuccin-mocha";
      background-opacity = 0.9;
      window-padding-x = 8;
      window-padding-y = 8;
      cursor-style = "bar";
      shell-integration = "bash";
    };
  };	
}
