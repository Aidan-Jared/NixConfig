{ self, inputs, ... }: {

  
  flake.homeModules.btop = { pkgs, ... }: {
    home.packages = [ pkgs.btop-cuda ];
    programs.btop = {
      # enable = true;
      settings = {
        vim_keys = true;
        gpu_mirror_graph = true;
        show_gpu_info = "Auto";
        shown_boxes = "cpu gpu0 mem";
        graph_symbol = "block";
      };
    };
  };

  flake.homeModules.atuin = { pkgs, ... }: {
    home.packages = [ pkgs.atuin ];
    programs.atuin = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        enter_accept = true;
        search_mode = "fuzzy";
        sync.records = true;
        daemon = {
          enabled = true;
          autostart = true;
        };
        stats = {
          common_subcommands = [
            "cargo"
            "uv"
            "nix"
            "nixos"
            "zellij"
            "hx"
            "git"
          ];
        };
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

  flake.homeModules.jj = { pkgs,... }: {
    home.packages = [
      pkgs.jujutsu
    ];
    programs.jujutsu = {
      enable = true;
      settings = {
        user.name = "Aidan-Jared";
        user.email = "AidanJared42@gmail.com";
      };
    };
  };
}
