{ pkgs, ... }:
{
  systemd.services.nix-daemon.serviceConfig = {
    Slice = "background.slice";
    CPUSchedulingPolicy = pkgs.lib.mkForce "idle";
    IOSchedulingClass = pkgs.lib.mkForce "idle";
  };
}
