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

  flake.nixosModules.cosmicGreeter = { pkgs, lib, ... }: {
    services.displayManager.cosmic-greeter.enable = true;
  };

  flake.nixosModules.noctaliaGreeter = { pkgs, lib, config, ... }:
  let
    system = pkgs.stdenv.hostPlatform.system;
    greeterPkg = inputs.noctalia-greeter.packages.${system}.default;

    greeterConf = pkgs.writeText "greeter.conf" ''
      # Session to pre-select (overridden by --session on the CLI, which we also pass)
      default_session = niri

      # Use the palette synced from Noctalia (appears after first sync or wallpaper symlink)
      scheme = Synced

      # Match Noctalia's dark mode
      # scale = 1.0  # uncomment and adjust if HiDPI scaling is needed
    '';
  in {
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

    systemd.tmpfiles.rules = [
      # State directory
      "d  /var/lib/noctalia-greeter              0755 greeter greeter -"

      # Deploy greeter.conf (C = copy-if-missing, won't overwrite runtime changes
      # like the greeter updating 'session' after a user picks one)
      "C  /var/lib/noctalia-greeter/greeter.conf 0644 greeter greeter - ${greeterConf}"

      # Wallpaper symlink — greeter reads this path directly
      "L+ /var/lib/noctalia-greeter/wallpaper    - - - - ${self.wallpaper}"
    ];
  };
}
