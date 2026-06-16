{ inputs, config, pkgs, ... }:
{
  # System-wide packages
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

    # wayland
    wayland
    wayland-utils
    xwayland
    libva-utils   # vainfo — useful for checking VA-API/Nvidia decode
    mesa-demos   
    vulkan-tools

    # Missing Core Dev Packages for compiling Rust crates smoothly
    pkg-config
    openssl
    gcc
    gnumake
    cmake


    # Text Editors
    helix        

    #nix
    nix-tree
    nix-search-cli
    nixpkgs-fmt
    nil
    
    #rust
    rustup

    # Python
    python3
    uv

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    glibc

    glib
    libGL
    libX11
    libXext
    libXrender
    libICE
    libSM
  ];
}
