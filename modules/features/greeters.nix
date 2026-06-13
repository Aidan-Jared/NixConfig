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

  flake.nixosModules.noctaliaGreeter = { pkgs, lib, config, ... }:
  let
    system = pkgs.stdenv.hostPlatform.system;
    greeterPkg = inputs.noctalia-greeter.packages.${system}.default;
  in{
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia-greeter = {
      enable = true;
      package = greeterPkg;
      greeter-args = "--session niri";
    };

    users.users.greeter = {
      isSystemUser = true;
      group = "greeter";
    };
    users.groups.greeter = {};
  };
}
