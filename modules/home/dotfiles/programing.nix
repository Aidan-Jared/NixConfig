{ self, inputs, ... }: {

  flake.homeModules.python = { pkgs, ... }: {
    home.packages = with pkgs; [
      ty
      python3
      uv
      ruff
    ];
  };
  
  flake.homeModules.rust = { pkgs, ... }: {
    home.packages = with pkgs; [
      bacon
      rustup
      cargo-watch
      cargo-expand
      cargo-nextest
      cargo-audit
      cargo-edit
      lldb
      mold
      sccache
    ];
    home.sessionVariables.RUSTC_WRAPPER = "sccache";
  };

  flake.homeModules.lsp = { pkgs, ... }: {
    home.packages = with pkgs; [
      nixfmt
      nil
      kdlfmt
      markdown-oxide
      tinymist

      # extra
      devenv
    ];
  };
}
