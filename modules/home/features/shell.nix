{ self, inputs, ... }:
{
  flake.homeModules.shellBash = { pkgs, lib, ... }: {
    home.sessionPath = [ "$HOME/.local/bin" ];
      programs.bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
            if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
              . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
            fi
            export PATH="$HOME/.local/bin:$PATH"
          '';
      shellAliases = rec {
        ls="eza --icons --git";
        ll="eza -la --icons --git";
        lt="eza --tree --icons";
        cat="bat";
        grep="rg";
        find="fd";

        n = "nix";
        nd = "nix develop -c $SHELL";
        ns = "nix shell";
        nsn = "nix shell nixpkgs#";
        nb = "nix build";
        nbn = "nix build nixpkgs#";
        nf = "nix flake";

        nr = "sudo nixos-rebuild --flake .";
        nrs = "sudo nixos-rebuild --flake . switch";
        snr = "sudo nixos-rebuild --flake .";
        snrs = "sudo nixos-rebuild --flake . switch";
        hm = "home-manager --flake .";
        hms = "home-manager --flake . switch";  };
      };

      programs.zoxide.enable = true;
      programs.starship= {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.starship;
      };
      programs.fzf.enable = true;

      programs.atuin = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.atuin;
      };

      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };  
  };
}
