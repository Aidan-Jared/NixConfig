{ self, inputs, ... }: {

  
  flake.homeModules.btop = { ... }: {
    programs.btop = {
      enable = true;
      settings = {
        vim_keys = true;
        gpu_mirror_graph = true;
        show_gpu_info = "Auto";
        shown_boxes = "cpu gpu0 mem";
      };
    };
  };
  
  flake.homeModules.git = { ... }: {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user.name = "Aidan-Jared";
        user.email = "AidanJared42@gmail.com";
      };
    };
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "https";
        prompt = "enabled";
        aliases.co = "pr checkout";
      };
    };
  };
}
