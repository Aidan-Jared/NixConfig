{ self, inputs, ... }: {
  flake.nixosModules.tuiGreeter = { pkgs, lib, ... }: {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd mango";
        user = "greeter";
        };
      };
    };
  };

  flake.nixosModules.gtkGreeter = { pkgs, lib, ... }: {
    environment.systemPackages = [
      pkgs.gtkgreet
      pkgs.greetd
    ];

    # environment.etc."greetd/niri-greeter.kdl".text = ''
    #   spawn-sh-at-startup "${pkgs.gtkgreet}/bin/gtkgreet -l -c ${self.packages.${pkgs.stdenv.hostPlatform.system}.niri}/bin/niri-session; niri msg action quit --skip-confirmation"
    # '';

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.gtkgreet}/bin/gtkgreet --config mango";
        user = "greeter";
      };
    };
  };

}
