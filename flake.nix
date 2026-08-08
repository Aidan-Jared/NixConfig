{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    
    import-tree = {
      url = "github:vic/import-tree";
    };

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
    };

    wrappers = {
      url = "github:Lassulus/wrappers";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    crane = {
      url = "github:ipetkov/crane";
    };

    helix = {
      url = "github:mattwparas/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bacon= {
      url = "github:Canop/bacon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bacon-ls= {
      url = "github:crisidev/bacon-ls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # herdr = {
    #   url = "github:ogulcancelik/herdr/v0.x.y";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stasis = {
    #   url = "github:saltnpepper97/stasis";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # noctalia = {
    #   url = "github:noctalia-dev/noctalia";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # noctalia-greeter = {
    #   url = "github:noctalia-dev/noctalia-greeter";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # waybar = {
    #   url = "github:Alexays/Waybar";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # vicinae = {
    #   url = "github:vicinaehq/vicinae";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # vicinae-extensions = {
    #   url = "github:vicinaehq/extensions";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins?ref=yazi-v0.2.5";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zed = {
    #   url = "github:zed-industries/zed";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib.fileset) toList fileFilter;

    isNixModule = file:
      file.hasExt "nix"
      && file.name != "flake.nix"
      && !lib.hasPrefix "_" file.name;

    importTree = path:
      toList (fileFilter isNixModule path);

    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
  in
    mkFlake {imports = importTree ./.;};
}
