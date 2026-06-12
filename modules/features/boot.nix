{ self, inputs, ... }: {

  flake.nixosModules.boot = { pkgs, lib, ... }: {
    
    networking.networkmanager.enable = true;
    
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    systemd.services.nix-daemon.serviceConfig = {
      Slice = "background.slice";
      CPUSchedulingPolicy = pkgs.lib.mkForce "idle";
      IOSchedulingClass = pkgs.lib.mkForce "idle";
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    services.power-profiles-daemon.enable = true;

    services.upower.enable = true;

    services.printing.enable = true;

    

    # Audio
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    programs.firefox.enable = true;
    programs.firefox.preferences = {
      "widget.gtk.libadwaita-colors.enabled" = false;
    };
  };

  flake.nixosModules.encrypt = { pkgs, lib, ... }: {
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    environment.systemPackages = [ pkgs.sbctl ]; # for key management + debugging

    boot.loader.systemd-boot.enable = lib.mkForce false; # lanzaboote replaces this
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    # TPM2 auto-unlock for LUKS (ties decryption to Secure Boot state)
    boot.initrd.systemd.enable = true;
    security.tpm2.enable = true;
  };
}
