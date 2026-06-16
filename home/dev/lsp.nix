{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt
    nil
    kdlfmt
    markdown-oxide
    tinymist
    lldb-dap
  ];
}
