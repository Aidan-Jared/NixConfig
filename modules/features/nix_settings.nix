{ self, inputs, ... }: {

  flake.nixosModules.nixSettings = { pkgs, lib, ... }: {
    system.autoUpgrade = {
      enable = true;
      flake = ".#baseMachine";
      flags = [ "--update-input" "nixpkgs" ];    
      dates = "weekly";
    };

    environment.sessionVariables = {
      TMPDIR = "/tmp";
    };

    nix.optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];

      max-jobs ="auto";
      cores = 0;
      sandbox = "relaxed";
      trusted-users = [ "root" "samantha" ];

      substituters = [
        "https://devenv.cachix.org"
        "https://cuda-nix.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://noctalia.cachix.org"
      ];
      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "cuda-nix.cachix.org-1:gbyvSgS9PzVnUWevSgLda9N6To9Zby3DkhYw8F3y4BM="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBc="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };  
  };
}
