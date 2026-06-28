{ self, inputs, ... }: {

  flake.nixosModules.users = { pkgs, lib, ... }: {

    users.users.samantha = {
      isNormalUser = true;
      description = "samantha";
      extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "video" "audio" ];
      shell = pkgs.bash;
    };

    users.users.samantha.group = "samantha";
    users.groups.samantha = {};

	};
}
