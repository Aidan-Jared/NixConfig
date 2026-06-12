{ self, inputs, ... }:
{
  flake.homeModules.helix = { pkgs, lib, ... }: {

    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        # theme = "github_dark_dimmed";

        editor = {
          auto-save = true;
          auto-format = true;
          gutters = [ "diff" "diagnostics" "line-numbers" "spacer" ];

          terminal = {
            command = "zellij";
            args = [ "run" "--direction" "down" "--" "bash" "-c" ];
          };

          statusline.right = [ "diagnostics" "selections" "position" "file-encoding" ];

          soft-wrap.enable = true;

          lsp = {
            display-inlay-hints = true;
            display-messages = true;
          };

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };

        keys.normal = {
          "C-p" = ":lsp-workspace-command tinymist.pinMain \"%sh{realpath %{buffer_name}}\"";
          "C-h" = ":sh zellij ac move-focus-or-tab left";
          "C-j" = ":sh zellij ac move-focus-or-tab down";
          "C-k" = ":sh zellij ac move-focus-or-tab up";
          "C-l" = ":sh zellij ac move-focus-or-tab right";

          "C-esc" = [
            "goto_first_nonwhitespace"
            "select_mode"
            "extend_to_line_end"
            ":sh zellij ac move-focus-or-tab right"
            ":pipe-to sh -c 'zellij ac write-chars \"$(cat)\n\"'"
            ":sh zellij ac move-focus-or-tab left"
            "move_visual_line_down"
            "goto_first_nonwhitespace"
            "collapse_selection"
            "normal_mode"
          ];

          "C-space" = [
            "select_mode"
            "extend_to_line_bounds"
            ":sh zellij ac move-focus-or-tab right"
            ":pipe-to sh -c 'zellij ac write-chars \"$(cat)\n\"'"
            ":sh zellij ac move-focus-or-tab left"
            "move_visual_line_down"
            "goto_first_nonwhitespace"
            "collapse_selection"
            "normal_mode"
          ];

          "C-y" = [
            ":sh rm -f /tmp/yazi-picker"
            ":insert-output yazi \"%{buffer_name}\" --chooser-file=/tmp/yazi-picker"
            ":sh printf \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
            ":open %sh{cat /tmp/yazi-picker}"
            ":redraw"
            ":set mouse false"
            ":set mouse true"
          ];

          # [keys.normal.C-a] nested table becomes a nested attrset
          "C-a" = {
            "C-a" = ":sh zellij ac toggle-floating-panes";
            h = ":sh zellij ac new-pane -d down";
            n = ":sh zellij ac new-pane";
            r = [
              ":sh zellij ac new-pane -d right -- devenv shell repl"
              ":sh zellij ac move-focus left"
            ];
            v = ":sh zellij ac new-pane -d right";
            z = ":sh zellij ac toggle-fullscreen";
          };

          "C-t".n = ":sh zellij ac new-tab";

          space.q = {
            q = ":sh zellij run -c -f -x 10% -y 10% --width 80% --height 80% -- bash ~/.config/helix/yazi-picker.sh open";
            v = ":sh zellij run -c -f -x 10% -y 10% --width 80% --height 80% -- bash ~/.config/helix/yazi-picker.sh vsplit";
            s = ":sh zellij run -c -f -x 10% -y 10% --width 80% --height 80% -- bash ~/.config/helix/yazi-picker.sh hsplit";
          };
        };

        keys.insert = {
          "C-esc" = [
            "goto_first_nonwhitespace"
            "select_mode"
            "extend_to_line_end"
            ":sh zellij ac move-focus-or-tab right"
            ":pipe-to sh -c 'zellij ac write-chars \"$(cat)\n\"'"
            ":sh zellij ac move-focus-or-tab left"
            "collapse_selection"
            "insert_mode"
          ];
          "C-space" = [
            "select_mode"
            "extend_to_line_bounds"
            ":sh zellij ac move-focus-or-tab right"
            ":pipe-to sh -c 'zellij ac write-chars \"$(cat)\n\"'"
            ":sh zellij ac move-focus-or-tab left"
            "collapse_selection"
            "insert_mode"
          ];
        };

        keys.select."C-space" = [
          ":sh zellij ac move-focus-or-tab right"
          ":pipe-to sh -c 'rg -v \"^[[:space:]]*$\" | zellij ac write-chars \"$(cat)\n\"'"
          ":sh zellij ac move-focus-or-tab left"
          "collapse_selection"
          "move_visual_line_down"
          "goto_first_nonwhitespace"
          "collapse_selection"
          "normal_mode"
        ];
      };

      languages = {
        language-server = {
          basedpyright = {
            command = "basedpyright-langserver";
            args = [ "--stdio" ];
            config.basedpyright.typeCheckingMode = "standard";
          };
          iwe.command = "iwes";
          markdown-oxide.command = "markdown-oxide";
          r-languageserver = { command = "R"; args = [ "--slave" "-e" "languageserver::run()" ]; };
          ruff = { command = "ruff"; args = [ "server" ]; };
          tinymist = {
            command = "tinymist";
            config.preview.background.enabled = true;
            config.preview.background.args = [ "--data-plane-host=127.0.0.1:0" "--invert-colors=never" "--open" ];
          };
          ty = { command = "ty"; args = [ "server" ]; };
          mojo-lsp-server = { command = "pixi"; args = [ "run" "mojo-lsp-server" ]; };
          taplo = { command = "taplo"; args = [ "lsp" "stdio" ]; config = {}; };

          ltex-ls-plus.config.ltex = {
            diagnosticSeverity = "warning";
            "ltex-ls".logLevel = "warning";
            disabledRules."en-US" = [ "PROFANITY" ];
            dictionary."en-US" = [ "builtin" ];
          };

          rust-analyzer = {
            command = "rust-analyzer";
            config = {
              cargo.allFeatures = true;
              procMacro.enable = true;
              rust.analyzerTargetDir = true;
              inlayHints = {
                bindingModeHints.enable = true;
                closureCaptureHints.enable = true;
                closingBraceHints.minLines = 10;
                lifetimeElisionHints.enable = "skip_trivial";
                typeHints.hideClosureInitialization = false;
              };
              check = {
                command = "clippy";
                allTargets = false;
              };
            };
          };

          bacon-ls.command = "bacon-ls";

          pylsp.config.pylsp.plugins = {
            pyflakes.enabled = true;
            pylint.enabled = false;
            black.enabled = true;
          };

          jedi = {
            command = "jedi-language-server";
            config.workspace.environmentPath = ".venv";
          };
        };

        language = [
          {
            name = "kdl";
            scope = "source.kdl";
            file-types = [ "kdl" ];
            comment-token = "//";
            block-comment-tokens = { start = "/*"; end = "*/"; };
            injection-regex = "kdl";
            formatter = { command = "kdlfmt"; args = [ "format" "-" ]; };
          }
          {
            name = "markdown";
            scope = "source.md";
            injection-regex = "md|markdown";
            file-types = [ "md" "livemd" "markdown" "mdx" "mkd" "mkdn" "mdwn" "mdown" "markdn" "mdtxt" "mdtext" "workbook" { glob = "PULLREQ_EDITMSG"; } ];
            roots = [ ".marksman.toml" ];
            language-servers = [ "marksman" "ltex-ls-plus" "markdown-oxide" "rumdl" ];
            indent = { tab-width = 2; unit = "  "; };
            block-comment-tokens = { start = "<!--"; end = "-->"; };
            auto-format = true;
            auto-pairs = {
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
            };
          }
          {
            name = "nix";
            scope = "source.nix";
            injection-regex = "nix";
            file-types = [ "nix" ];
            shebangs = [];
            comment-token = "#";
            block-comment-tokens = { start = "/*"; end = "*/"; };
            language-servers = [ "nil" "nixd" ];
            indent = { tab-width = 2; unit = "  "; };
            formatter = { command = "nixfmt"; };
          }
          {
            name = "python";
            scope = "source.python";
            injection-regex = "py(thon)?";
            file-types = [ "py" "pyi" "py3" "pyw" "ptl" "rpy" "cpy" "ipy" "pyt"
              { glob = ".python_history"; } { glob = ".pythonstartup"; } { glob = ".pythonrc"; }
              { glob = "*SConstruct"; } { glob = "*SConscript"; } { glob = "*sconstruct"; }
            ];
            shebangs = [ "python" "uv" ];
            roots = [ "pyproject.toml" "setup.py" "poetry.lock" "pyrightconfig.json" ];
            comment-token = "#";
            language-servers = [ "ruff" "ty" "jedi" ];
            auto-format = true;
            formatter = { command = "ruff"; args = [ "format" "-" ]; };
            indent = { tab-width = 4; unit = "    "; };
            debugger = {
              name = "debugpy";
              transport = "stdio";
              command = ".venv/bin/python";
              args = [ "-m" "debugpy.adapter" ];
              templates = [
                {
                  name = "source";
                  request = "launch";
                  completion = [ { name = "entrypoint"; default = "."; completion = "filename"; } ];
                  args = { mode = "debug"; program = "{0}"; console = "internalConsole"; };
                }
              ];
            };
          }
          {
            name = "rust";
            scope = "source.rust";
            injection-regex = "rs|rust";
            file-types = [ "rs" ];
            roots = [ "Cargo.toml" "Cargo.lock" ];
            shebangs = [ "rust-script" "cargo" ];
            formatter.command = "rustfmt";
            comment-tokens = [ "//" "///" "//!" ];
            block-comment-tokens = [
              { start = "/*"; end = "*/"; }
              { start = "/**"; end = "*/"; }
              { start = "/*!"; end = "*/"; }
            ];
            auto-format = true;
            language-servers = [ "rust-analyzer" "bacon-ls" ];
            indent = { tab-width = 4; unit = "    "; };
            persistent-diagnostic-sources = [ "rustc" "clippy" ];
            auto-pairs = {
              "(" = ")"; "{" = "}"; "[" = "]"; "\"" = "\""; "`" = "`";
            };
            debugger = {
              name = "lldb-dap";
              transport = "stdio";
              command = "lldb-dap";
              templates = [
                {
                  name = "binary";
                  request = "launch";
                  completion = [ { name = "binary"; completion = "filename"; default = "target/debug/"; } ];
                  args = { program = "{0}"; runInTerminal = false; };
                }
                {
                  name = "binary (terminal)";
                  request = "launch";
                  completion = [ { name = "binary"; completion = "filename"; } ];
                  args = { program = "{0}"; runInTerminal = true; };
                }
                {
                  name = "attach";
                  request = "attach";
                  completion = [ "pid" ];
                  args = { pid = "{0}"; };
                }
                {
                  name = "gdbserver attach";
                  request = "attach";
                  completion = [
                    { name = "lldb connect url"; default = "connect://localhost:3333"; }
                    { name = "file"; completion = "filename"; }
                    "pid"
                  ];
                  args.attachCommands = [
                    "platform select remote-gdb-server"
                    "platform connect {0}"
                    "file {1}"
                    "attach {2}"
                  ];
                }
              ];
            };
          }
          {
            name = "typst";
            language-servers = [ "tinymist" "ltex-ls-plus" ];
          }
          {
            name = "toml";
            scope = "source.toml";
            injection-regex = "toml";
            file-types = [ "toml" { glob = "pdm.lock"; } { glob = "poetry.lock"; } { glob = "Cargo.lock"; } { glob = "uv.lock"; } ];
            comment-token = "#";
            language-servers = [ "taplo" ];
            indent = { tab-width = 2; unit = "  "; };
          }
          {
            name = "mojo";
            scope = "source.mojo";
            roots = [ "pixi.toml" "pixi.lock" ];
            injection-regex = "mojo";
            file-types = [ "mojo" "🔥" ];
            language-servers = [ "mojo-lsp-server" ];
            comment-token = "#";
            indent = { tab-width = 4; unit = "    "; };
            auto-format = true;
            formatter = { command = "pixi"; args = [ "run" "mojo" "format" "-q" "-" ]; };
          }
        ];

        grammar = [
          {
            name = "kdl";
            source = { git = "https://github.com/amaanq/tree-sitter-kdl"; rev = "3ca569b9f9af43593c24f9e7a21f02f43a13bb88"; };
          }
          {
            name = "python";
            source = { git = "https://github.com/tree-sitter/tree-sitter-python"; rev = "293fdc02038ee2bf0e2e206711b69c90ac0d413f"; };
          }
          {
            name = "rust";
            source = { git = "https://github.com/tree-sitter/tree-sitter-rust"; rev = "261b20226c04ef601adbdf185a800512a5f66291"; };
          }
          {
            name = "nix";
            source = { git = "https://github.com/nix-community/tree-sitter-nix"; rev = "1b69cf1fa92366eefbe6863c184e5d2ece5f187d"; };
          }
        ];
      };
    };
  };
}
