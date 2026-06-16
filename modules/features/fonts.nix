{ self, inputs, ... }: {

  flake.nixosModules.fonts = { pkgs, lib, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
