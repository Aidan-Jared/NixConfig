{ pkgs, ... }:
{
  imports = [
    ./zed.nix
  ];

  home.packages = [
    # code editors
    pkgs.vscode
    pkgs.zed-editor
  ];
  
}
