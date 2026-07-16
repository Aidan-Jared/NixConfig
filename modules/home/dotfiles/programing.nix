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
      cargo-generate
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
      texlive.combined.scheme-full
   	  typst
   	  taplo
    ];
  };

  flake.homeModules.rLang = { pkgs, ... }: {
    home.packages = with pkgs; [
      R
      rPackages.littler
      rPackages.tidyverse
    ];
  };

  flake.homeModules.devenv = { pkgs, ... }: {
    home.packages = with pkgs; [
      devenv
    ];

  };
}
