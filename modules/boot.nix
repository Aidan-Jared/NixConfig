
{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

 boot.zfs.forceImportRoot = false;

  systemd.services.nix-daemon.serviceConfig = {
    Slice = "background.slice";
    CPUSchedulingPolicy = pkgs.lib.mkForce "idle";
    IOSchedulingClass = pkgs.lib.mkForce "idle";
  };
}
