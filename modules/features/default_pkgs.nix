{ self, inputs, ... }: {

  flake.nixosModules.defaultPkgs = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      lvm2
      git
      curl
      wget
      rsync
      file
      pciutils
      usbutils
      stdenv.cc.cc.lib
      zlib
      pkg-config
      openssl
      gcc
      gnumake
      cmake
      pcmanfm

      # Text Editors
      helix        

      #nix
      nix-tree
      nix-search-cli
      nixpkgs-fmt
      nil
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      glibc
    ];

    xdg.mime.defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
    };
  };
}
