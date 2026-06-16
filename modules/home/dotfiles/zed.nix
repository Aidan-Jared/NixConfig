{ self, inputs, ... }: {
  flake.homeModules.zed = { pkgs, lib, ... }: {

    home.packages = [
      inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    
    programs.zed-editor = {

      enable = true;

      extensions = [
        "HTML"
        "TOML"
        "Git Firefly"
        "Catppuccin Icons"
        "Github Theme"
        "LaTex"
        "Nix"
        "CSV"
        "Rainbow CSV"
        "Typst"
        "R"
        "Tombi | TOML Toolkit"
        "ltex"
        "Rust Snippets"
        "Air"
        "Quarto"
      ];
  
      userSettings ={
        cli_default_open_behavior = "existing_window";
        project_panel = {
          dock = "left";
        };
        outline_panel = {
          dock = "left";
        };
        collaboration_panel = {
          dock =  "left";
        };
        preview_tabs = {
          enabled = true;
        };
        experimental.theme_overrides = {
          editor.debugger_active_line.background = "#f5f50044";
        };
        # buffer_font_family = "Fira Code";
        buffer_font_features = {
          calt = true;
        };
        buffer_font_weight = 600;
        ui_font_size = 16.0;
        cursor_shape = "bar";
        zoomed_padding = true;
        active_pane_modifiers = {
          inactive_opacity = 0.7;
        };
        tab_bar = {
          show_pinned_tabs_in_separate_row = false;
          show_nav_history_buttons = true;
          show = true;
        };
        title_bar = {
          show_onboarding_banner = true;
          show_project_items = true;
        };
        session = {
          trust_all_worktrees = true;
        };
        redact_private_values = true;
        git_panel = {
          dock = "left";
          status_style = "icon";
          tree_view = true;
        };
        diagnostics = {
          inline = {
            enabled = true;
          };
        };
        minimap = {
          display_in = "all_editors";
          show = "always";
        };
        agent = {
          sidebar_side = "right";
          dock = "right";
          button = false;
          favorite_models = [];
          model_parameters = [];
        };
        tabs = {
          file_icons = true;
          git_status = true;
          show_diagnostics = "all";
        };
        status_bar = {
          active_encoding_button = "enabled";
          active_language_button = true;
        };
        icon_theme = {
          mode = "system";
          light = "VSCode Icons for Zed (Dark NestJS)";
          dark = "Catppuccin Frappé";
        };
        base_keymap = "VSCode";
        toolbar = {
          code_actions = false;
          selections_menu = true;
          quick_actions = true;
          breadcrumbs = true;
          agent_review = false;
        };
        inlay_hints = {
          show_value_hints = false;
          enabled = true;
          show_type_hints = true;
          show_parameter_hints = true;
          show_other_hints = true;
        };
        show_completions_on_input = true;
        show_completion_documentation = true;
        show_signature_help_after_edits = false;
        remove_trailing_whitespace_on_save = true;
        jupyter = {
          kernel_selections = {
            r = "ark";
            python = ".venv/bin/python";
            Rust = "evcxr";
          };
        };
        # auto_signature_help = true;
        languages = {
          "Python" = {
            colorize_brackets = true;
            indent_guides = {
              background_coloring = "disabled";
            };
            language_servers = [ "ty" "ruff" ];
            formatter = {
              "language_server"= {  name = "ruff"; };
            };
            code_actions_on_format = {
              source.organizeImports.ruff = true;
            };
            format_on_save = "on";
            soft_wrap = "none";
            auto_indent_on_paste = true;
          };
          LaTeX = {
            soft_wrap = "editor_width";
            language_servers = [ "texlab" "harper-ls" "ltex" "..." ];
          };
          Typst = {
            soft_wrap = "editor_width";
            language_servers = [ "tinymist" "harper-ls" "ltex" "..." ];
          };
          Markdown = {
            soft_wrap = "editor_width";
            language_servers = [ "harper-ls" "ltex" "..." ];
            format_on_save = "on";
            formatter = {
              external = {
                command = "prettier";
                arguments = [ "--stdin-filepath" "{buffer_path}" ];
              };
            };
            remove_trailing_whitespace_on_save = false;
          };
          R = {
            show_edit_predictions = false;
            language_servers = [ "air" "r-languageserver" "ruff" "..." ];
            use_on_type_format = true;
            colorize_brackets = true;
            soft_wrap = "editor_width";
            indent_guides = {
              background_coloring = "disabled";
            };
            formatter = {
              external = {
                command = "R";
                arguments = [ "--slave" "-e" "languageserver::run()" ];
              };
            };
            format_on_save = "on";
          };
          Rust = {
            show_edit_predictions = false;
            colorize_brackets = true;
            indent_guides = {
              background_coloring = "disabled";
            };
            format_on_save = "on";
            formatter = "language_server";
            soft_wrap = "none";
            auto_indent_on_paste = true;
            remove_trailing_whitespace_on_save = true;
          };
          Quarto = {
            language_servers = [ "r_language_server" "ruff" "harper-ls" "ltex" ];
            format_on_save = "on";
            soft_wrap =  "editor_width";
          };
        };
        lsp = {
          air = {
            binary = {
              path_lookup = true;
              arguments = [ "language-server"];
            };
          };
          basedpyright = {
            settings = {
              python = {
                pythonPath = ".venv/bin/python";
              };
              basedpyright = {
                typeCheckingMode =  "standard";
              };
            };
          };
          ltex = {
            settings = {
              ltex = {
                language =  "en-US";
                diagnosticSeverity =  "warning";
                dictionary = { "en-US" = [ "builtin" ]; };
                disabledRules = {
                  en-US = [ "PROFANITY"];
                };
              };
            };
          };
          rust-analyzer = {
            enable_lsp_tasks = true;
            binary= { path = lib.getExe pkgs.rust-analyzer; };
            initialization_options = {
              rust= { analyzerTargetDir = true; };
              cargo = { allFeatures = true; };
              procMacro = { enable = true; };
              check = {
                command = "clippy";
                allTargets = false;
              };
              inlayHints = {
                bindingModeHints= { enable = true; };
                closureCaptureHints= { "enable" = true; };
                lifetimeElisionHints = {
                  enable =  "skip_trivial";
                  useParameterNames = true;
                };
                closureReturnTypeHints= { enable =  "always"; };
                chainingHints = { enable = true; };
                parameterHints= { enable = true; };
                typeHints= { enable = true; };
              };
            };
          };
          r_language_server = {
            initialization_options = {
              diagnostics = true;
              rich_documentation = true;
            };
          };
          texlab = {
            settings = {
              texlab = {
                build = {
                  executable = "latexmk";
                  args = [ "-pdf"  "-interaction=nonstopmode" "-synctex=1" "%f"];
                  onSave = true;
                };
                latexindent = {
                  modifyLineBreaks = false;
                };
              };
            };
          };
          tinymist = {
            initialization_options = {
              preview = {
                background = {
                  enabled = true;
                };
                invertColors = "never";
                autoOpenPreview = "onStartup";
                refresh = "onType";
              };
            };
            settings = {
              exportPdf =  "onSave";
              outputPath =  "$root/$name";
            };
          };
        };
        search = {
          regex = true;
          button = true;
        };
        debugger = {
          stepping_granularity =  "statement";
          dock =  "left";
          button = true;
        };
        disable_ai = false;
        helix_mode = true;
        which_key = {
          enabled = true;
          delay_ms = 0;
        };
        file_types = {
          R= [ "rmd" "Rmd" "RMD" "qmd" ];
        };
        file_scan_exclusions = [
          "**/.git"
          "**/node_modules"
          "**/__pycache__"
          "**/.DS_Store"
          "**/target"
          "**/_output"
        ];
        autosave= { after_delay = { milliseconds = 1500; }; };
        restore_on_startup =  "launchpad";
        scrollbar = {
          git_diff = false;
          diagnostics = "all";
        };
        terminal = {
          font_family = "FiraCode Nerd Font";
          env = {
            EDITOR =  "zed --wait";
            TERM = "cosmic";
          };
          dock = "bottom";
          working_directory =  "current_project_directory";
          detect_venv = {
            on = {
              directories = [ ".env" "env" ".venv" "venv" ];
            };
          };
        };
      }; 
    };
  };
}
