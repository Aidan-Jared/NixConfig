{ self, inputs, ... }: {

  flake.homeModules.python = { pkgs, ... }: {
    home.packages = with pkgs; [
      ty
      python3
      uv
      ruff
    ];
  };
  
  flake.homeModules.rust = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      # rustup
      rustc
      cargo
      (lib.hiPrio rust-analyzer)
      inputs.bacon.defaultPackage.${pkgs.stdenv.hostPlatform.system}
      inputs.bacon-ls.defaultPackage.${pkgs.stdenv.hostPlatform.system}
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
      # texlive.combined.scheme-small
   	  typst
   	  taplo
    ];
  };

  flake.homeModules.rLang = { pkgs, ... }: {
    home.packages = with pkgs; [
      R
      air-formatter
      # quarto
      # rPackages.littler
      rPackages.tidyverse
      rPackages.knitr
      rPackages.rmarkdown
    ];
  };

  flake.homeModules.devenv = { pkgs, ... }: {
    home.packages = with pkgs; [
      devenv
    ];

  };
}
