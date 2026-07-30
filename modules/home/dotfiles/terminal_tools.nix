{ self, inputs, ... }: {

  flake.wrappersModules.btop = { config, wlib, lib, pkgs, ... }: {
    imports = [ inputs.wrapper-modules.wrapperModules.btop ];
    config.package = pkgs.btop-cuda;

    config.settings = {
        vim_keys = true;
        gpu_mirror_graph = true;
        show_gpu_info = "Auto";
        shown_boxes = "cpu gpu0 mem";
        graph_symbol = "block";
      };
  };

  flake.wrappersModules.atuin = { config, wlib, lib, pkgs, ... }: {
    imports = [ inputs.wrapper-modules.wrapperModules.atuin ];
    config.package = pkgs.atuin;
    config.settings = {
        enter_accept = true;
        search_mode = "fuzzy";
        sync.records = true;
        daemon = {
          enabled = true;
          autostart = true;
        };
      };
  };

  flake.wrappersModules.git = { config, wlib, lib, pkgs, ... }: {
    imports = [ inputs.wrapper-modules.wrapperModules.git ];
    config.package = pkgs.git;
    config.settings = {
        init.defaultBranch = "main";
        user = {
          name = "Aidan-Jared";
          email = "AidanJared42@gmail.com";
        };
      };
  };


  perSystem = { pkgs, ... }: {
    packages.btop = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      imports = [ self.wrappersModules.btop ];
    };
    packages.atuin = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      imports = [ self.wrappersModules.atuin ];
    };
    packages.git = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      imports = [ self.wrappersModules.git ];
    };
  };
}
