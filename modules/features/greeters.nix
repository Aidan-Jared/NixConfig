{ self, inputs, ... }: {

  flake.nixosModules.tuiGreeter = { pkgs, lib, ... }: {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${self.packages.${pkgs.stdenv.hostPlatform.system}.niri}/bin/niri-session";
        user = "greeter";
        };
      };
    };
  };
}
