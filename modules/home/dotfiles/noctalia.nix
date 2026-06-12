{ self, inputs, ... }: {
  flake.homeModules.noctalia = { pkgs, lib, ... }: {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      # enable = true;
    };
  };
}
