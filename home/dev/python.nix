{ pkgs, ... }:
{
  home.packages = with pkgs; [    
    # python
    ty
    ruff
  ];
}
