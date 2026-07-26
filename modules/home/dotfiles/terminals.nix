{ self, inputs, ... }: {

  flake.wrappersModules.ghostty = { config, wlib, lib, pkgs, ... }: {
    imports = [ wlib.modules.default ];

    config.package = pkgs.ghostty;

    config.flagSeparator = "=";

    config.flags = {
      "--confirm-close-surface" = "false";
      "--font-size" = "12";
      "--background-opacity" = "0.9";
      "--background-blur" = "true";
      "--window-padding-x" = "8";
      "--window-padding-y" = "8";
      "--cursor-style" = "bar";
      "--shell-integration" = "bash";
      "--window-decoration" = "none";
      # "--config-default-files" = "false";
    };
  };

  perSystem = { pkgs, ... }: {
    packages.ghostty = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      imports = [ self.wrappersModules.ghostty ];
    };
  };
}
