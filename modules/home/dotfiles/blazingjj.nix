{
  inputs,
  self,
  ...
}: {
  perSystem = { pkgs, ... }: {
    # 1. Evaluate your custom wrapper module and expose it as a package
    packages.blazingjj = 
      (self.wrappersModules.blazingjj.apply {
        inherit pkgs;
      }).wrapper;

    # Your existing jujutsu package configuration
    packages.jujutsu = let
      defaultRevset = "all()";
      logCommand = ["log" "--reversed" "--no-pager" "-r" defaultRevset "-n" "20"];
    in
      (inputs.wrappers.wrapperModules.jujutsu.apply {
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
      }).wrapper;
  };

  # 2. Define the structural wrapper module for blazingjj
  flake.wrappersModules.blazingjj = inputs.wrappers.lib.wrapModule (
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
            hash  = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };
          commonArgs = { inherit src; };
          cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        in 
          craneLib.buildPackage (commonArgs // { inherit cargoArtifacts; });

        # Bind the generated configuration into the environment variable blazingjj looks for
        # (Assuming it reads BLAZINGJJ_CONFIG_DIR or similar, adjust if it takes a direct file path)
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
}
