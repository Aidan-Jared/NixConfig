{
  description = "Workstation Infrastructure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    #hyprland.url = "github:hyprwm/Hyprland/v0.47.2";
    #hyprland.inputs.nixpkgs.follows = "nixpkgs";
    #xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    #xdg-desktop-portal-hyprland.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # elephant.url = "github:abenz1267/elephant";
    # walker = {
    #   url = "github:abenz1267/walker";
    #   inputs.elephant.follows = "elephant";
    # };
    niri.url = "github:sodiboo/niri-flake";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins?ref=yazi-v0.2.5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
#hyprland, 
  outputs = { self, nixpkgs, home-manager, stylix, noctalia, niri, nix-yazi-plugins,... } @ inputs:
    let
      system = "x86_64-linux";
      hmConfig = {
        useGlobalPkgs        = true;
        useUserPackages      = true;
        backupFileExtension  = "bak";
        extraSpecialArgs     = { inherit inputs;  };#hyprland;
        users.samantha       = { imports = [ ./home.nix ]; };
        # Pull the HM hyprland module in for every user
        #sharedModules        = [ hyprland.homeManagerModules.default ];
      };    
    in {

      # main
      nixosConfigurations.samantha = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          { 
            nixpkgs.config.allowUnfree = true;
         #   nixpkgs.config.cudaSupport = true;
          }
          ./configuration.nix
          stylix.nixosModules.stylix
         # niri.nixosModules.niri
          #hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          { home-manager = hmConfig; }
        ];
      };

      # gaming
    nixosConfigurations.samantha-gaming = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.config.allowUnfree = true;
        #  nixpkgs.config.cudaSupport = true;
        }
        ./configuration.nix
        ./gaming/config.nix
     #   hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        { home-manager = hmConfig; }
      ];
    };    
      nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              git

              (pkgs.writeShellScriptBin "install-nixos" ''
                set -e

                echo "==> Available disks:"
                lsblk

                read -p "Target disk (e.g. nvme0n1): " DISK
                DISK="/dev/$DISK"

                echo "==> Partitioning $DISK..."
                sudo parted $DISK -- mklabel gpt
                sudo parted $DISK -- mkpart ESP fat32 1MB 512MB
                sudo parted $DISK -- mkpart primary 512MB 100%
                sudo parted $DISK -- set 1 esp on

                echo "==> Formatting..."
                sudo mkfs.fat -F 32 ''${DISK}p1
                sudo mkfs.ext4 ''${DISK}p2

                echo "==> Mounting..."
                sudo mount ''${DISK}p2 /mnt
                sudo mkdir -p /mnt/boot
                sudo mount ''${DISK}p1 /mnt/boot

                echo "==> Generating hardware config..."
                sudo nixos-generate-config --root /mnt
                cp /mnt/etc/nixos/hardware-configuration.nix ~/nixos-config/hardware-configuration.nix

                echo "==> Hardware config copied. Review it before continuing:"
                cat ~/nixos-config/hardware-configuration.nix
                read -p "Looks good? (y/n): " CONFIRM
                if [ "$CONFIRM" != "y" ]; then
                  echo "Aborting. Edit ~/nixos-config/hardware-configuration.nix and re-run nixos-install manually."
                  exit 1
                fi

                echo "==> Installing..."
                    sudo nixos-install --flake ~/nixos-config#samantha

                    echo "==> Done! Reboot when ready."
              '')
            ];

            environment.loginShellInit = ''
              if [ ! -d ~/nixos-config ]; then
                git clone https://github.com/Aidan-Jared/NixConfig ~/nixos-config
                echo "config cloned Run: install-nixos"
              fi
            '';
          })
        ];
      };
    };
}
