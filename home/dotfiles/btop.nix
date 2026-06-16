
{ pkgs, ... }:
{
	# home.packages = with pkgs; [
	#   btop-cuda
	# ];
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      gpu_mirror_graph = true;
      show_gpu_info = "Auto";
      shown_boxes = "cpu gpu0 mem";
    };
  };
}
