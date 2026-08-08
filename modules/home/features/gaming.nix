
{self, inputs, ...}: {
  flake.homeModules.gaming = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = with pkgs; [
      lutris
      steam-run
      dxvk
      # parsec-bin

      gamescope

      mangohud

      r2modman

      heroic

      er-patcher
      bottles

      steamtinkerlaunch

      prismlauncher

      lsfg-vk
      lsfg-vk-ui
    ];
  };
}
