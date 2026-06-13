  { self, inputs, ... }: {

    flake.nixosModules.nvidia = { pkgs, lib, config, ... }: {

      environment.systemPackages = [ pkgs.linuxPackages.nvidia_x11 ];

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

flake.nixosModules.nvidiaCuda = { pkgs, lib, config, ... }: let
  cfg = config.hardware.nvidiaCuda;
  cudaPkg = cfg.cudaPackages;
  in {

    options.hardware.nvidiaCuda = {
      enable = lib.mkEnableOption "NVIDIA CUDA support";

      cudaPackages = lib.mkOption {
        type    = lib.types.attrs;
        default = pkgs.cudaPackages_12;
        description = "CUDA package set (e.g. pkgs.cudaPackages_12).";
      };

      extras = {
        jax   = lib.mkEnableOption "JAX uv index hint + env vars";
        torch = lib.mkEnableOption "PyTorch uv index hint + env vars";
      };
    };

    config = lib.mkIf cfg.enable {

      nixpkgs.config.cudaSupport = true;

      environment.systemPackages = [
        pkgs.cudaPkg.cuda_nvcc
        pkgs.cudaPkg.cudatoolkit
        pkgs.cudaPkg.cudnn
        pkgs.cudaPkg.libcublas
        pkgs.cudaPkg.libcufft
        pkgs.cudaPkg.libcurand
        pkgs.cudaPkg.libcusolver
        pkgs.cudaPkg.libcusparse
      ];

      environment.variables = {
        CUDA_PATH       = "${cudaPkg.cudatoolkit}";
        LD_LIBRARY_PATH = builtins.concatStringsSep ":" [
          "/run/opengl-driver/lib"
          "/run/opengl-driver-32/lib"
          "${pkgs.stdenv.cc.cc.lib}/lib"
          "${pkgs.zlib}/lib"
        ];
        XLA_FLAGS = "--xla_gpu_cuda_data_dir=${pkgs.cudaPkg.cudatoolkit}";
      } // lib.optionalAttrs cfg.extras.jax {
        JAX_PLATFORMS = "cuda,cpu";
      } // lib.optionalAttrs cfg.extras.torch {
        TORCH_CUDA_ARCH_LIST = "8.0;8.6;8.9;9.0";
      };
    };

  };
}
