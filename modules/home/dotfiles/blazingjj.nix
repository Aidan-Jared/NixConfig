{
  self,
  inputs,
  ...
}: let
  # 1. Define the structural wrapper module for blazingjj locally
  blazingjjModule = inputs."wrapper-modules".lib.wrapModule (
    {
      config,
      lib,
      ...
    }: let
      tomlFormat = config.pkgs.formats.toml {};
    in {
      options = {
        settings = lib.mkOption {
          type = tomlFormat.type;
          default = {};
        };
      };

      config = {
        # Build your custom binary inside the module context using crane
        package = let
          craneLib = inputs.crane.mkLib config.pkgs;
          src = config.pkgs.fetchFromGitHub {
            owner = "blazingjj";
            repo  = "blazingjj";
            rev   = "main";
            hash  = "sha256-srziScxQ1i89U3BhK0sZeUT9Q6hVHpa5ZqlBi70c9m0=";
          };
          commonArgs = { inherit src; };
          cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        in 
          craneLib.buildPackage (commonArgs // { inherit cargoArtifacts; });

        # Bind the generated configuration into the environment variable blazingjj looks for
        env = {
          BLAZINGJJ_CONFIG_DIR = let
            generatedFile = tomlFormat.generate "config.toml" config.settings;
          in
            config.pkgs.runCommand "blazingjj-config-dir" {} ''
              mkdir -p $out
              cp ${generatedFile} $out/config.toml
            '';
        };
      };
    }
  );
in {
  perSystem = { pkgs, ... }: {
    # 2. Evaluate your custom wrapper module and expose it as a package
    # FIXED: Accessing the local 'blazingjjModule' directly
    packages.blazingjj = 
      (blazingjjModule.apply {
        inherit pkgs;
      }).wrapper;

    # Your existing jujutsu package configuration
    packages.jujutsu = let
      defaultRevset = "all()";
      logCommand = ["log" "--reversed" "--no-pager" "-r" defaultRevset "-n" "20"];
    in
      (inputs."wrapper-modules".wrappers.jujutsu.wrap {
        inherit pkgs;
        settings = {
          user = {
            name = "Aidan-Jared";
            email = "AidanJared42@gmail.com";
          };
          aliases.l = logCommand;
          ui.default-command = logCommand;
          ui.editor = "hx";
        };
      });
  };

  flake.homeModules.jj = { pkgs, lib, ... }: {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.blazingjj
    ];
    programs.jujutsu = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.jujutsu;
    };
  };
}
