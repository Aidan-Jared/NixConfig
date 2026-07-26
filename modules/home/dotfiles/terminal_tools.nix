{ self, inputs, ... }: {

  flake.wrappersModules.btop = { config, wlib, lib, pkgs, ... }: {
    imports = [ wlib.modules.default ];
    config.package = pkgs.btop-cuda;

    config.constructFiles."btop.conf" = {
      relPath = "etc/btop.conf";
      content = ''
        vim_keys = true
        gpu_mirror_graph = true
        show_gpu_info = "Auto"
        shown_boxes = "cpu gpu0 mem"
        graph_symbol = "block"
      '';
    };

    config.addFlag = [ [ "--config" config.constructFiles."btop.conf".path ] ];
  };

  flake.wrappersModules.atuin = { config, wlib, lib, pkgs, ... }: {
    imports = [ wlib.modules.default ];
    config.package = pkgs.atuin;

    config.constructFiles."config.toml" = {
      relPath = "etc/atuin/config.toml";
      content = lib.generators.toTOML { } {
        enter_accept = true;
        search_mode = "fuzzy";
        sync.records = true;
        daemon = {
          enabled = true;
          autostart = true;
        };
      };
    };

    config.env.ATUIN_CONFIG_DIR = builtins.dirOf config.constructFiles."config.toml".path;
  };

  flake.wrappersModules.git = { config, wlib, lib, pkgs, ... }: {
    imports = [ wlib.modules.default ];
    config.package = pkgs.git;

    config.constructFiles.gitconfig = {
      relPath = "etc/gitconfig";
      content = lib.generators.toINI { } {
        init.defaultBranch = "main";
        user = {
          name = "Aidan-Jared";
          email = "AidanJared42@gmail.com";
        };
      };
    };

    config.env.GIT_CONFIG_GLOBAL = config.constructFiles.gitconfig.path;
  };

  flake.wrappersModules.gh = { config, wlib, lib, pkgs, ... }: {
    imports = [ wlib.modules.default ];
    config.package = pkgs.gh;

    config.constructFiles."config.yml" = {
      relPath = "etc/gh/config.yml";
      content = lib.generators.toYAML { } {
        git_protocol = "https";
        prompt = "enabled";
        aliases.co = "pr checkout";
      };
    };

    config.env.GH_CONFIG_DIR = builtins.dirOf config.constructFiles."config.yml".path;
  };

  perSystem = { pkgs, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
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
    packages.gh = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      imports = [ self.wrappersModules.gh ];
    };
  };
}
