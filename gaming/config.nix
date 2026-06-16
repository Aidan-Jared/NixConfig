{ config, inputs, ... }:
{

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.prime = {
  #   offload = {
  #     enable = true;
  #     enableOffloadCmd = true; 
  #   };

    # intelBusId = "";
    # nvidiaBusId = "";
    # amdgpuBusId = "";
  # };
}
