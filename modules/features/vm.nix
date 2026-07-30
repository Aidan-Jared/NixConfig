
{ self, inputs, ... }:
{
  flake.nixosModules.VM = { pkgs, lib, ... }: {
    environment.systemPackages = [ pkgs.distrobox ];
		virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
   };
}
