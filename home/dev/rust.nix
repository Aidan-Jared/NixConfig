{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # rust
    bacon
    cargo-watch
    cargo-expand
    cargo-nextest
    cargo-audit
    cargo-edit
    lldb
    mold
    sccache
  ];

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };
  
}
