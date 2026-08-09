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

  flake.nixosModules.lyGreeter = { pkgs, lib, ... }: {
    services.displayManager.ly = {
      enable = true;
    };
  };

  # flake.nixosModules.nocGreeter = { pkgs, lib, ... }: {
  #   imports = [
  #     inputs.noctalia-greeter.nixosModules.default
  #   ];

  #   programs.noctalia-greeter = {
  #     enable = true;
  #     settings = {
  #       session.default = "mango";
  #        appearance = {
  #         hide_logo = true;
  #         theme_mode = "dark";
  #         font_family = "Fira Code";
  #         wallpaper = {
  #           path = "${self.wallpaper}";
  #           fill_mode = "fit";
  #         };
  #       };
  #     };
  #   };
      
  # };

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
