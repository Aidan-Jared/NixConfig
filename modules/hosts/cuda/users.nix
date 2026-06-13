{ self, inputs, ... }: {

  flake.nixosModules.users = { pkgs, lib, ... }: {

    # Define user account
    users.users.samantha = {
      isNormalUser = true;
      description = "samantha";
      extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "video" "audio" ];
      shell = pkgs.bash; # Sets Zsh as default shell so home-manager settings hook in
    };

    users.users.samantha.group = "samantha";
    users.groups.samantha = {};

	};
}
