{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "cyber-noir-m";
      default_mode = "normal";
      default_layout = "default";
      scrollback_editor = "hx";
      on_force_close = "detach";

      web_client.font = "monospace";

      plugins = {
        about.location          = "zellij:about";
        compact-bar.location    = "zellij:compact-bar";
        configuration.location  = "zellij:configuration";
        filepicker = {
          location = "zellij:strider";
          cwd = "/";
        };
        plugin-manager.location  = "zellij:plugin-manager";
        session-manager.location = "zellij:session-manager";
        status-bar.location      = "zellij:status-bar";
        strider.location         = "zellij:strider";
        tab-bar.location         = "zellij:tab-bar";
        welcome-screen = {
          location = "zellij:session-manager";
          welcome_screen = true;
        };
        zjstatus.location = "file:~/.config/zellij/plugins/zjstatus.wasm";
      };

      load_plugins._children = [
        { "zellij:link" = {}; }
      ];

      keybinds._props.clear-defaults = true;

      keybinds.normal._children = [
        {
          bind = {
            _args = ["Alt g"];
            _children = [
              {
                Run._args = ["gitui"];
                floating = true;
                close_on_exit = true;
              }
            ];
          };
        }
        {
          bind = {
            _args = ["Alt o"];
            _children = [
              {
                LaunchOrFocusPlugin._args = ["zellij:layout-manager"];
                floating = true;
                move_to_focused_tab = true;
              }
            ];
          };
        }
      ];

      keybinds.locked._children = [
        { bind = { _args = ["Ctrl g"]; SwitchToMode._args = ["normal"]; }; }
      ];

      keybinds.pane._children = [
        { bind = { _args = ["left"];  MoveFocus._args = ["left"];  }; }
        { bind = { _args = ["down"];  MoveFocus._args = ["down"];  }; }
        { bind = { _args = ["up"];    MoveFocus._args = ["up"];    }; }
        { bind = { _args = ["right"]; MoveFocus._args = ["right"]; }; }
        { bind = { _args = ["h"]; MoveFocus._args = ["left"];  }; }
        { bind = { _args = ["j"]; MoveFocus._args = ["down"];  }; }
        { bind = { _args = ["k"]; MoveFocus._args = ["up"];    }; }
        { bind = { _args = ["l"]; MoveFocus._args = ["right"]; }; }
        { bind._args = ["c"]; _children = [{ SwitchToMode._args = ["renamepane"]; } { PaneNameInput._args = [0]; }]; }
        { bind = { _args = ["d"]; _children = [{ NewPane._args = ["down"]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["e"]; _children = [{ TogglePaneEmbedOrFloating = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["f"]; _children = [{ ToggleFocusFullscreen = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["i"]; _children = [{ TogglePanePinned = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["n"]; _children = [{ NewPane = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["p"]; SwitchFocus = {}; }; }
        { bind = { _args = ["Ctrl p"]; SwitchToMode._args = ["normal"]; }; }
        { bind = { _args = ["r"]; _children = [{ NewPane._args = ["right"]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["s"]; _children = [{ NewPane._args = ["stacked"]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["w"]; _children = [{ ToggleFloatingPanes = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["z"]; _children = [{ TogglePaneFrames = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
      ];

      keybinds.tab._children = [
        { bind = { _args = ["left"];  GoToPreviousTab = {}; }; }
        { bind = { _args = ["right"]; GoToNextTab = {}; }; }
        { bind = { _args = ["h"]; GoToPreviousTab = {}; }; }
        { bind = { _args = ["l"]; GoToNextTab = {}; }; }
        { bind = { _args = ["1"]; _children = [{ GoToTab._args = [1]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["2"]; _children = [{ GoToTab._args = [2]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["3"]; _children = [{ GoToTab._args = [3]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["4"]; _children = [{ GoToTab._args = [4]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["5"]; _children = [{ GoToTab._args = [5]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["6"]; _children = [{ GoToTab._args = [6]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["7"]; _children = [{ GoToTab._args = [7]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["8"]; _children = [{ GoToTab._args = [8]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["9"]; _children = [{ GoToTab._args = [9]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["["]; _children = [{ BreakPaneLeft = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["]"]; _children = [{ BreakPaneRight = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["b"]; _children = [{ BreakPane = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["n"]; _children = [{ NewTab = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["r"]; _children = [{ SwitchToMode._args = ["renametab"]; } { TabNameInput._args = [0]; }]; }; }
        { bind = { _args = ["s"]; _children = [{ ToggleActiveSyncTab = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["Ctrl t"]; SwitchToMode._args = ["normal"]; }; }
        { bind = { _args = ["x"]; _children = [{ CloseTab = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["tab"]; ToggleTab = {}; }; }
      ];

      keybinds.resize._children = [
        { bind = { _args = ["h"]; Resize._args = ["Increase left"];  }; }
        { bind = { _args = ["j"]; Resize._args = ["Increase down"];  }; }
        { bind = { _args = ["k"]; Resize._args = ["Increase up"];    }; }
        { bind = { _args = ["l"]; Resize._args = ["Increase right"]; }; }
        { bind = { _args = ["H"]; Resize._args = ["Decrease left"];  }; }
        { bind = { _args = ["J"]; Resize._args = ["Decrease down"];  }; }
        { bind = { _args = ["K"]; Resize._args = ["Decrease up"];    }; }
        { bind = { _args = ["L"]; Resize._args = ["Decrease right"]; }; }
        { bind = { _args = ["+"]; Resize._args = ["Increase"]; }; }
        { bind = { _args = ["-"]; Resize._args = ["Decrease"]; }; }
        { bind = { _args = ["="]; Resize._args = ["Increase"]; }; }
        { bind = { _args = ["Ctrl n"]; SwitchToMode._args = ["normal"]; }; }
      ];

      keybinds.move._children = [
        { bind = { _args = ["h"]; MovePane._args = ["left"];  }; }
        { bind = { _args = ["j"]; MovePane._args = ["down"];  }; }
        { bind = { _args = ["k"]; MovePane._args = ["up"];    }; }
        { bind = { _args = ["l"]; MovePane._args = ["right"]; }; }
        { bind = { _args = ["Ctrl h"]; SwitchToMode._args = ["normal"]; }; }
        { bind = { _args = ["n"]; MovePane = {}; }; }
        { bind = { _args = ["p"]; MovePaneBackwards = {}; }; }
        { bind = { _args = ["tab"]; MovePane = {}; }; }
      ];

      keybinds.scroll._children = [
        { bind = { _args = ["e"]; _children = [{ EditScrollback = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["s"]; _children = [{ SwitchToMode._args = ["entersearch"]; } { SearchInput._args = [0]; }]; }; }
      ];

      keybinds.search._children = [
        { bind = { _args = ["c"]; SearchToggleOption._args = ["CaseSensitivity"]; }; }
        { bind = { _args = ["n"]; Search._args = ["down"]; }; }
        { bind = { _args = ["o"]; SearchToggleOption._args = ["WholeWord"]; }; }
        { bind = { _args = ["p"]; Search._args = ["up"]; }; }
        { bind = { _args = ["w"]; SearchToggleOption._args = ["Wrap"]; }; }
      ];

      keybinds.session._children = [
        { bind._args = ["Ctrl o"]; _children = [{ SwitchToMode._args = ["normal"]; }]; }
        { bind._args = ["a"]; _children = [{ LaunchOrFocusPlugin._args = ["zellij:about"]; floating = true; move_to_focused_tab = true; } { SwitchToMode._args = ["normal"]; }]; }
        { bind._args = ["c"]; _children = [{ LaunchOrFocusPlugin._args = ["configuration"]; floating = true; move_to_focused_tab = true; } { SwitchToMode._args = ["normal"]; }]; }
        { bind._args = ["l"]; _children = [{ LaunchOrFocusPlugin._args = ["zellij:layout-manager"]; floating = true; move_to_focused_tab = true; } { SwitchToMode._args = ["normal"]; }]; }
        { bind._args = ["p"]; _children = [{ LaunchOrFocusPlugin._args = ["plugin-manager"]; floating = true; move_to_focused_tab = true; } { SwitchToMode._args = ["normal"]; }]; }
        { bind._args = ["s"]; _children = [{ LaunchOrFocusPlugin._args = ["zellij:share"]; floating = true; move_to_focused_tab = true; } { SwitchToMode._args = ["normal"]; }]; }
        { bind._args = ["w"]; _children = [{ LaunchOrFocusPlugin._args = ["session-manager"]; floating = true; move_to_focused_tab = true; } { SwitchToMode._args = ["normal"]; }]; }
      ];

      "keybinds.shared_except \"locked\""._children = [
        { bind = { _args = ["Alt +"]; Resize._args = ["Increase"]; }; }
        { bind = { _args = ["Alt -"]; Resize._args = ["Decrease"]; }; }
        { bind = { _args = ["Alt ="]; Resize._args = ["Increase"]; }; }
        { bind = { _args = ["Alt ["]; PreviousSwapLayout = {}; }; }
        { bind = { _args = ["Alt ]"]; NextSwapLayout = {}; }; }
        { bind = { _args = ["Alt f"]; ToggleFloatingPanes = {}; }; }
        { bind = { _args = ["Ctrl g"]; SwitchToMode._args = ["locked"]; }; }
        { bind = { _args = ["Alt i"]; MoveTab._args = ["left"]; }; }
        { bind = { _args = ["Alt n"]; NewPane = {}; }; }
        { bind = { _args = ["Alt o"]; MoveTab._args = ["right"]; }; }
        { bind = { _args = ["Alt p"]; TogglePaneInGroup = {}; }; }
        { bind = { _args = ["Alt Shift p"]; ToggleGroupMarking = {}; }; }
        { bind = { _args = ["Ctrl q"]; Quit = {}; }; }
        { bind._args = ["Ctrl y"]; _children = [{ LaunchOrFocusPlugin._args = ["file:~/.config/zellij/plugins/room.wasm"]; floating = true; ignore_case = true; quick_jump = true; }]; }
      ];

      "keybinds.shared_except \"locked\" \"move\""._children = [
        { bind = { _args = ["Ctrl h"]; SwitchToMode._args = ["move"]; }; }
      ];
      "keybinds.shared_except \"locked\" \"session\""._children = [
        { bind = { _args = ["Ctrl o"]; SwitchToMode._args = ["session"]; }; }
      ];
      "keybinds.shared_except \"locked\" \"tab\""._children = [
        { bind = { _args = ["Ctrl t"]; SwitchToMode._args = ["tab"]; }; }
      ];
      "keybinds.shared_except \"locked\" \"pane\""._children = [
        { bind = { _args = ["Ctrl p"]; SwitchToMode._args = ["pane"]; }; }
      ];
      "keybinds.shared_except \"locked\" \"resize\""._children = [
        { bind = { _args = ["Ctrl n"]; SwitchToMode._args = ["resize"]; }; }
      ];
      "keybinds.shared_except \"locked\" \"scroll\" \"search\" \"tmux\""._children = [
        { bind = { _args = ["Ctrl b"]; SwitchToMode._args = ["tmux"]; }; }
      ];
      "keybinds.shared_except \"locked\" \"scroll\" \"search\""._children = [
        { bind = { _args = ["Ctrl s"]; SwitchToMode._args = ["scroll"]; }; }
      ];
      "keybinds.shared_except \"normal\" \"locked\" \"entersearch\""._children = [
        { bind = { _args = ["enter"]; SwitchToMode._args = ["normal"]; }; }
      ];
      "keybinds.shared_except \"normal\" \"locked\" \"entersearch\" \"renametab\" \"renamepane\""._children = [
        { bind = { _args = ["esc"]; SwitchToMode._args = ["normal"]; }; }
      ];
      "keybinds.shared_among \"pane\" \"tmux\""._children = [
        { bind = { _args = ["x"]; _children = [{ CloseFocus = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
      ];
      "keybinds.shared_among \"scroll\" \"search\""._children = [
        { bind = { _args = ["PageDown"]; PageScrollDown = {}; }; }
        { bind = { _args = ["PageUp"];   PageScrollUp = {}; }; }
        { bind = { _args = ["j"]; ScrollDown = {}; }; }
        { bind = { _args = ["k"]; ScrollUp = {}; }; }
        { bind = { _args = ["d"]; HalfPageScrollDown = {}; }; }
        { bind = { _args = ["u"]; HalfPageScrollUp = {}; }; }
        { bind = { _args = ["Ctrl b"]; PageScrollUp = {}; }; }
        { bind = { _args = ["Ctrl f"]; PageScrollDown = {}; }; }
        { bind = { _args = ["Ctrl c"]; _children = [{ ScrollToBottom = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["Ctrl s"]; SwitchToMode._args = ["normal"]; }; }
      ];
      "keybinds.shared_among \"session\" \"tmux\""._children = [
        { bind = { _args = ["d"]; Detach = {}; }; }
      ];

      keybinds.entersearch._children = [
        { bind = { _args = ["Ctrl c"]; SwitchToMode._args = ["scroll"]; }; }
        { bind = { _args = ["esc"];    SwitchToMode._args = ["scroll"]; }; }
        { bind = { _args = ["enter"];  SwitchToMode._args = ["search"]; }; }
      ];
      keybinds.renametab._children = [
        { bind = { _args = ["esc"]; _children = [{ UndoRenameTab = {}; } { SwitchToMode._args = ["tab"]; }]; }; }
      ];
      "keybinds.shared_among \"renametab\" \"renamepane\""._children = [
        { bind = { _args = ["Ctrl c"]; SwitchToMode._args = ["normal"]; }; }
      ];
      keybinds.renamepane._children = [
        { bind = { _args = ["esc"]; _children = [{ UndoRenamePane = {}; } { SwitchToMode._args = ["pane"]; }]; }; }
      ];

      keybinds.tmux._children = [
        { bind = { _args = ["left"];  _children = [{ MoveFocus._args = ["left"];  } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["down"];  _children = [{ MoveFocus._args = ["down"];  } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["up"];    _children = [{ MoveFocus._args = ["up"];    } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["right"]; _children = [{ MoveFocus._args = ["right"]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["h"]; _children = [{ MoveFocus._args = ["left"];  } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["j"]; _children = [{ MoveFocus._args = ["down"];  } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["k"]; _children = [{ MoveFocus._args = ["up"];    } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["l"]; _children = [{ MoveFocus._args = ["right"]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["space"]; NextSwapLayout = {}; }; }
        { bind = { _args = ["\""]; _children = [{ NewPane._args = ["down"]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["%"];  _children = [{ NewPane._args = ["right"]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = [","]; SwitchToMode._args = ["renametab"]; }; }
        { bind = { _args = ["["]; SwitchToMode._args = ["scroll"]; }; }
        { bind = { _args = ["Ctrl b"]; _children = [{ Write._args = [2]; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["c"]; _children = [{ NewTab = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["n"]; _children = [{ GoToNextTab = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["o"]; FocusNextPane = {}; }; }
        { bind = { _args = ["p"]; _children = [{ GoToPreviousTab = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
        { bind = { _args = ["z"]; _children = [{ ToggleFocusFullscreen = {}; } { SwitchToMode._args = ["normal"]; }]; }; }
      ];

      # themes.cyber-noir-m = {
      #   text_unselected    = { base = "229 233 240"; background = "59 66 82"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "163 190 140"; emphasis_3 = "180 142 173"; };
      #   text_selected      = { base = "229 233 240"; background = "59 66 82"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "163 190 140"; emphasis_3 = "180 142 173"; };
      #   ribbon_selected    = { base = "59 66 82"; background = "163 190 140"; emphasis_0 = "191 97 106"; emphasis_1 = "208 135 112"; emphasis_2 = "180 142 173"; emphasis_3 = "129 161 193"; };
      #   ribbon_unselected  = { base = "59 66 82"; background = "216 222 233"; emphasis_0 = "191 97 106"; emphasis_1 = "229 233 240"; emphasis_2 = "129 161 193"; emphasis_3 = "180 142 173"; };
      #   table_title        = { base = "163 190 140"; background = "0"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "163 190 140"; emphasis_3 = "180 142 173"; };
      #   table_cell_selected   = { base = "229 233 240"; background = "46 52 64"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "163 190 140"; emphasis_3 = "180 142 173"; };
      #   table_cell_unselected = { base = "229 233 240"; background = "59 66 82"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "163 190 140"; emphasis_3 = "180 142 173"; };
      #   list_selected      = { base = "229 233 240"; background = "46 52 64"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "163 190 140"; emphasis_3 = "180 142 173"; };
      #   list_unselected    = { base = "229 233 240"; background = "59 66 82"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "163 190 140"; emphasis_3 = "180 142 173"; };
      #   frame_selected     = { base = "196 167 231"; background = "0"; emphasis_0 = "208 135 112"; emphasis_1 = "136 192 208"; emphasis_2 = "180 142 173"; emphasis_3 = "0"; };
      #   frame_highlight    = { base = "196 167 231"; background = "0"; emphasis_0 = "180 142 173"; emphasis_1 = "208 135 112"; emphasis_2 = "208 135 112"; emphasis_3 = "208 135 112"; };
      #   exit_code_success  = { base = "163 190 140"; background = "0"; emphasis_0 = "136 192 208"; emphasis_1 = "59 66 82"; emphasis_2 = "180 142 173"; emphasis_3 = "129 161 193"; };
      #   exit_code_error    = { base = "191 97 106"; background = "0"; emphasis_0 = "235 203 139"; emphasis_1 = "0"; emphasis_2 = "0"; emphasis_3 = "0"; };
      #   multiplayer_user_colors = { player_1 = "180 142 173"; player_2 = "129 161 193"; player_3 = "0"; player_4 = "235 203 139"; player_5 = "136 192 208"; player_6 = "0"; player_7 = "191 97 106"; player_8 = "0"; player_9 = "0"; player_10 = "0"; };
      # };
    };

    layouts = {
      default = {
        layout._children = [
          {
            pane = {
              size = 1;
              borderless = true;
              plugin.location = "file:~/.config/zellij/plugins/zjstatus.wasm";
              _children = [
                { format_left = "{mode}#[fg=#cba6f7] {session} #[fg=#6c7086]|#[fg=#a6e3a1] {tabs}"; }
                { mode_normal  = "#[bg=#a6e3a1,fg=#1e1e2e,bold] NORMAL ";  }
                { mode_locked  = "#[bg=#f38ba8,fg=#1e1e2e,bold] LOCKED ";  }
                { mode_pane    = "#[bg=#89b4fa,fg=#1e1e2e,bold] PANE ";    }
                { mode_tab     = "#[bg=#89dceb,fg=#1e1e2e,bold] TAB ";     }
                { mode_resize  = "#[bg=#fab387,fg=#1e1e2e,bold] RESIZE ";  }
                { mode_scroll  = "#[bg=#f9e2af,fg=#1e1e2e,bold] SCROLL ";  }
                { mode_search  = "#[bg=#f9e2af,fg=#1e1e2e,bold] SEARCH ";  }
                { mode_session = "#[bg=#cba6f7,fg=#1e1e2e,bold] SESSION "; }
                { mode_move    = "#[bg=#fab387,fg=#1e1e2e,bold] MOVE ";    }
                { mode_tmux    = "#[bg=#f38ba8,fg=#1e1e2e,bold] TMUX ";    }
                { mode_default_to_mode = "normal"; }
                { tab_normal     = "#[fg=#6c7086] {index} {name} ";        }
                { tab_active     = "#[fg=#cba6f7,bold] {index} {name} ";   }
                { tab_fullscreen = "#[fg=#f38ba8,bold] {index} {name} [] ";}
                { tab_sync       = "#[fg=#f9e2af,bold] {index} {name} <> ";}
              ];
            };
          }
          { pane._props.split_direction = "horizontal"; _children = [{ pane = {}; }]; }
          { pane = { size = 2; borderless = true; plugin.location = "zellij:status-bar"; }; }
        ];
      };

      dev = {
        layout._children = [
          {
            pane = {
              size = 1;
              borderless = true;
              plugin.location = "file:~/.config/zellij/plugins/zjstatus.wasm";
              _children = [
                { format_left  = "{mode}#[fg=#cba6f7] {session} #[fg=#6c7086]|#[fg=#a6e3a1] {tabs}"; }
                { format_right = "#[fg=#6c7086]| #[fg=#cba6f7]{git_branch} {git_ahead_behind} #[fg=#6c7086]| #[fg=#89b4fa]{datetime}"; }
                { mode_normal  = "#[bg=#a6e3a1,fg=#1e1e2e,bold] NORMAL ";  }
                { mode_locked  = "#[bg=#f38ba8,fg=#1e1e2e,bold] LOCKED ";  }
                { mode_pane    = "#[bg=#89b4fa,fg=#1e1e2e,bold] PANE ";    }
                { mode_tab     = "#[bg=#89dceb,fg=#1e1e2e,bold] TAB ";     }
                { mode_resize  = "#[bg=#fab387,fg=#1e1e2e,bold] RESIZE ";  }
                { mode_scroll  = "#[bg=#f9e2af,fg=#1e1e2e,bold] SCROLL ";  }
                { mode_search  = "#[bg=#f9e2af,fg=#1e1e2e,bold] SEARCH ";  }
                { mode_session = "#[bg=#cba6f7,fg=#1e1e2e,bold] SESSION "; }
                { mode_move    = "#[bg=#fab387,fg=#1e1e2e,bold] MOVE ";    }
                { mode_tmux    = "#[bg=#f38ba8,fg=#1e1e2e,bold] TMUX ";    }
                { mode_default_to_mode = "normal"; }
                { tab_normal     = "#[fg=#6c7086] {index} {name} ";        }
                { tab_active     = "#[fg=#cba6f7,bold] {index} {name} ";   }
                { tab_fullscreen = "#[fg=#f38ba8,bold] {index} {name} [] ";}
                { tab_sync       = "#[fg=#f9e2af,bold] {index} {name} <> ";}
              ];
            };
          }
          {
            pane._props.split_direction = "vertical";
            _children = [
              { pane = { size = "70%"; command = "hx"; _children = [{ args = "."; }]; }; }
              { pane = { size = "30%"; command = "bacon"; _children = [{ args = "clippy"; }]; }; }
            ];
          }
          { pane = { size = 2; borderless = true; plugin.location = "zellij:status-bar"; }; }
        ];
      };
    };
  };
}
