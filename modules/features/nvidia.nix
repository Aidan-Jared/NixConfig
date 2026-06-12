{ self, inputs, ... }: {

  flake.nixosModules.nvidia = { pkgs, lib, config, ... }: {

    boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    boot.kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

  
    # NVIDIA RTX 4090 Configuration
    nixpkgs.config.allowUnfree = true;
  #  nixpkgs.config.cudaSupport = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # ── Optimus / dual-GPU laptops only ──────────────────────────────────
      # Uncomment ONE of the two blocks below if you have Intel+Nvidia.
      # Get BusIDs from: lspci | grep -E 'VGA|3D'

      # Option A — sync mode (Nvidia drives everything, best Wayland compat)
      # prime = {
      #   sync.enable  = true;
      #   intelBusId   = "PCI:0:2:0";
      #   nvidiaBusId  = "PCI:1:0:0";
      # };

      # Option B — offload mode (saves battery, use `nvidia-offload <app>`)
      # prime = {
      #   offload = {
      #     enable           = true;
      #     enableOffloadCmd = true;
      #   };
      #   intelBusId  = "PCI:0:2:0";
      #   nvidiaBusId = "PCI:1:0:0";
      # };
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        nvidia-vaapi-driver  # hardware video decode via VA-API
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };
}
