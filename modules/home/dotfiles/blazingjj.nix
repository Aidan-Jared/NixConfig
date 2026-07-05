
{ self, inputs, ... }: {
  flake.homeModules.blazingjj = { pkgs, lib, ... }: {

    blazingjj = let
        craneLib = inputs.crane.mkLib pkgs;
        src = pkgs.fetchFromGitHub {
          owner = "blazingjj";
          repo  = "blazingjj";
          rev   = "main";
          hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
        commonArgs = { inherit src; };
        cargoArtifacts = craneLib.buildDepsOnly commonArgs;
      in craneLib.buildPackage (commonArgs // { inherit cargoArtifacts; });
  };
}
