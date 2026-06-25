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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    crane = {
      url = "github:ipetkov/crane";
    };

    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.3";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };


    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri = {
    #   url = "github:sodiboo/niri-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nirimap = {
    #   url = "github:alexandergknoll/nirimap";
    #   flake = false;
    # };
    
    # pandora = {
    #   url = "github:PandorasFox/pandora";
    #   flake = false;
    # };
    
    system76-scheduler-niri = {
      url = "github:Kirottu/system76-scheduler-niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);
}
