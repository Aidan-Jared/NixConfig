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
    systemd.tmpfiles.rules = [
      # Ensure the state dir exists with correct ownership
      "d  /var/lib/noctalia-greeter              0755 greeter greeter -"

      # Deploy greeter.conf on first boot (C = copy-if-missing, preserves runtime writes)
      # "C  /var/lib/noctalia-greeter/greeter.conf 0644 greeter greeter - ${greeterConf}"

      # Wallpaper: symlink a store-path wallpaper so the greeter finds it without
      # needing the GUI "Sync Now". Noctalia's sync writes to this same path.
      # Replace ${self.wallpaper} with any absolute path or store path you prefer,
      # e.g. "${./wallpaper.png}" for a file next to your flake.
      "L+ /var/lib/noctalia-greeter/wallpaper    - - - - ${self.wallpaper}"
      ];
  };
}
