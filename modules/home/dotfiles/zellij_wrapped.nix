{ self, inputs, ... }: {

  flake.wrappersModules.zellij = { config, wlib, lib, pkgs, ... }: let
    # TODO: replace these with your actual zjstatus / room plugin derivations
    # (e.g. inputs.zjstatus.packages.${pkgs.stdenv.hostPlatform.system}.default)
    # zjstatusWasm = "file:~/.config/zellij/plugins/zjstatus.wasm";
    roomWasm = "file:~/.config/zellij/plugins/room.wasm";
  in {
    imports = [ wlib.modules.default ];
    config.package = pkgs.zellij;

    config.constructFiles."config.kdl" = {
      relPath = "etc/zellij/config.kdl";
      content = ''
        default_mode "normal"
        default_layout "default"
        scrollback_editor "hx"
        on_force_close "detach"
        theme "cyber-noir-m"

        web_client {
            font "monospace"
        }

        plugins {
            about location="zellij:about"
            compact-bar location="zellij:compact-bar"
            configuration location="zellij:configuration"
            filepicker location="zellij:strider" {
                cwd "/"
            }
            plugin-manager location="zellij:plugin-manager"
            session-manager location="zellij:session-manager"
            status-bar location="zellij:status-bar"
            strider location="zellij:strider"
            tab-bar location="zellij:tab-bar"
            welcome-screen location="zellij:session-manager" {
                welcome_screen false
            }
            zjstatus location="file:${pkgs.zellijPlugins.zjstatus}"
        }

        load_plugins {
            "zellij:link"
        }

        ui {
            pane_frames {
                rounded_corners true
            }
        }

        keybinds clear-defaults=false {
            normal {
                bind "Alt g" {
                    Run "blazingjj" {
                        floating true
                        close_on_exit true
                    }
                }
                bind "Alt o" {
                    LaunchOrFocusPlugin "zellij:layout-manager" {
                        floating true
                        move_to_focused_tab true
                    }
                    SwitchToMode "normal"
                }
            }
            locked {
                bind "Ctrl g" { SwitchToMode "normal"; }
                bind "Alt g" {
                    Run "blazingjj" {
                        floating true
                        close_on_exit true
                    }
                }
            }
            pane {
                bind "left" { MoveFocus "left"; }
                bind "down" { MoveFocus "down"; }
                bind "up" { MoveFocus "up"; }
                bind "right" { MoveFocus "right"; }
                bind "h" { MoveFocus "left"; }
                bind "j" { MoveFocus "down"; }
                bind "k" { MoveFocus "up"; }
                bind "l" { MoveFocus "right"; }
                bind "c" { SwitchToMode "renamepane"; PaneNameInput 0; }
                bind "d" { NewPane "down"; SwitchToMode "normal"; }
                bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "normal"; }
                bind "f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
                bind "i" { TogglePanePinned; SwitchToMode "normal"; }
                bind "n" { NewPane; SwitchToMode "normal"; }
                bind "p" { SwitchFocus; }
                bind "Ctrl p" { SwitchToMode "normal"; }
                bind "r" { NewPane "right"; SwitchToMode "normal"; }
                bind "s" { NewPane "stacked"; SwitchToMode "normal"; }
                bind "w" { ToggleFloatingPanes; SwitchToMode "normal"; }
                bind "z" { TogglePaneFrames; SwitchToMode "normal"; }
            }
            tab {
                bind "left" { GoToPreviousTab; }
                bind "right" { GoToNextTab; }
                bind "h" { GoToPreviousTab; }
                bind "l" { GoToNextTab; }
                bind "down" { GoToNextTab; }
                bind "up" { GoToPreviousTab; }
                bind "j" { GoToNextTab; }
                bind "k" { GoToPreviousTab; }
                bind "1" { GoToTab 1; SwitchToMode "normal"; }
                bind "2" { GoToTab 2; SwitchToMode "normal"; }
                bind "3" { GoToTab 3; SwitchToMode "normal"; }
                bind "4" { GoToTab 4; SwitchToMode "normal"; }
                bind "5" { GoToTab 5; SwitchToMode "normal"; }
                bind "6" { GoToTab 6; SwitchToMode "normal"; }
                bind "7" { GoToTab 7; SwitchToMode "normal"; }
                bind "8" { GoToTab 8; SwitchToMode "normal"; }
                bind "9" { GoToTab 9; SwitchToMode "normal"; }
                bind "[" { BreakPaneLeft; SwitchToMode "normal"; }
                bind "]" { BreakPaneRight; SwitchToMode "normal"; }
                bind "b" { BreakPane; SwitchToMode "normal"; }
                bind "n" { NewTab; SwitchToMode "normal"; }
                bind "r" { SwitchToMode "renametab"; TabNameInput 0; }
                bind "s" { ToggleActiveSyncTab; SwitchToMode "normal"; }
                bind "Ctrl t" { SwitchToMode "normal"; }
                bind "x" { CloseTab; SwitchToMode "normal"; }
                bind "tab" { ToggleTab; }
            }
            resize {
                bind "h" { Resize "Increase left"; }
                bind "j" { Resize "Increase down"; }
                bind "k" { Resize "Increase up"; }
                bind "l" { Resize "Increase right"; }
                bind "H" { Resize "Decrease left"; }
                bind "J" { Resize "Decrease down"; }
                bind "K" { Resize "Decrease up"; }
                bind "L" { Resize "Decrease right"; }
                bind "+" { Resize "Increase"; }
                bind "-" { Resize "Decrease"; }
                bind "=" { Resize "Increase"; }
                bind "Ctrl n" { SwitchToMode "normal"; }
            }
            move {
                bind "h" { MovePane "left"; }
                bind "j" { MovePane "down"; }
                bind "k" { MovePane "up"; }
                bind "l" { MovePane "right"; }
                bind "left" { MovePane "left"; }
                bind "down" { MovePane "down"; }
                bind "up" { MovePane "up"; }
                bind "right" { MovePane "right"; }
                bind "Ctrl h" { SwitchToMode "normal"; }
                bind "n" { MovePane; }
                bind "p" { MovePaneBackwards; }
                bind "tab" { MovePane; }
            }
            scroll {
                bind "e" { EditScrollback; SwitchToMode "normal"; }
                bind "s" { SwitchToMode "entersearch"; SearchInput 0; }
                bind "Alt left" { MoveFocusOrTab "left"; SwitchToMode "normal"; }
                bind "Alt down" { MoveFocus "down"; SwitchToMode "normal"; }
                bind "Alt up" { MoveFocus "up"; SwitchToMode "normal"; }
                bind "Alt right" { MoveFocusOrTab "right"; SwitchToMode "normal"; }
                bind "Alt h" { MoveFocusOrTab "left"; SwitchToMode "normal"; }
                bind "Alt j" { MoveFocus "down"; SwitchToMode "normal"; }
                bind "Alt k" { MoveFocus "up"; SwitchToMode "normal"; }
                bind "Alt l" { MoveFocusOrTab "right"; SwitchToMode "normal"; }
            }
            search {
                bind "c" { SearchToggleOption "CaseSensitivity"; }
                bind "n" { Search "down"; }
                bind "o" { SearchToggleOption "WholeWord"; }
                bind "p" { Search "up"; }
                bind "w" { SearchToggleOption "Wrap"; }
            }
            session {
                bind "Ctrl o" { SwitchToMode "normal"; }
                bind "a" { LaunchOrFocusPlugin "zellij:about" { floating true; move_to_focused_tab true; }; SwitchToMode "normal"; }
                bind "c" { LaunchOrFocusPlugin "configuration" { floating true; move_to_focused_tab true; }; SwitchToMode "normal"; }
                bind "l" { LaunchOrFocusPlugin "zellij:layout-manager" { floating true; move_to_focused_tab true; }; SwitchToMode "normal"; }
                bind "p" { LaunchOrFocusPlugin "plugin-manager" { floating true; move_to_focused_tab true; }; SwitchToMode "normal"; }
                bind "s" { LaunchOrFocusPlugin "zellij:share" { floating true; move_to_focused_tab true; }; SwitchToMode "normal"; }
                bind "w" { LaunchOrFocusPlugin "session-manager" { floating true; move_to_focused_tab true; }; SwitchToMode "normal"; }
            }
            shared_except "locked" {
                bind "Alt +" { Resize "Increase"; }
                bind "Alt -" { Resize "Decrease"; }
                bind "Alt =" { Resize "Increase"; }
                bind "Alt [" { PreviousSwapLayout; }
                bind "Alt ]" { NextSwapLayout; }
                bind "Alt f" { ToggleFloatingPanes; }
                bind "Ctrl g" { SwitchToMode "locked"; }
                bind "Alt i" { MoveTab "left"; }
                bind "Alt n" { NewPane; }
                bind "Alt o" { MoveTab "right"; }
                bind "Alt p" { TogglePaneInGroup; }
                bind "Alt Shift p" { ToggleGroupMarking; }
                bind "Ctrl q" { Quit; }
                bind "Ctrl y" {
                    LaunchOrFocusPlugin "file:${roomWasm}" {
                        floating true
                        ignore_case true
                        quick_jump true
                    }
                }
                bind "alt f" {
                    LaunchPlugin "filepicker" {
                        close_on_section true
                    }
                }
            }
            shared_except "locked" "move" {
                bind "Ctrl h" { SwitchToMode "move"; }
            }
            shared_except "locked" "session" {
                bind "Ctrl o" { SwitchToMode "session"; }
            }
            shared_except "locked" "tab" {
                bind "Ctrl t" { SwitchToMode "tab"; }
            }
            shared_except "locked" "pane" {
                bind "Ctrl p" { SwitchToMode "pane"; }
            }
            shared_except "locked" "resize" {
                bind "Ctrl n" { SwitchToMode "resize"; }
            }
            shared_except "locked" "scroll" "search" "tmux" {
                bind "Ctrl b" { SwitchToMode "tmux"; }
            }
            shared_except "locked" "scroll" "search" {
                bind "Ctrl s" { SwitchToMode "scroll"; }
            }
            shared_except "normal" "locked" "entersearch" {
                bind "enter" { SwitchToMode "normal"; }
            }
            shared_except "normal" "locked" "entersearch" "renametab" "renamepane" {
                bind "esc" { SwitchToMode "normal"; }
            }
            shared_among "pane" "tmux" {
                bind "x" { CloseFocus; SwitchToMode "normal"; }
            }
            shared_among "scroll" "search" {
                bind "PageDown" { PageScrollDown; }
                bind "PageUp" { PageScrollUp; }
                bind "j" { ScrollDown; }
                bind "k" { ScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                bind "Ctrl b" { PageScrollUp; }
                bind "Ctrl f" { PageScrollDown; }
                bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
                bind "Ctrl s" { SwitchToMode "normal"; }
            }
            shared_among "session" "tmux" {
                bind "d" { Detach; }
            }
            entersearch {
                bind "Ctrl c" { SwitchToMode "scroll"; }
                bind "esc" { SwitchToMode "scroll"; }
                bind "enter" { SwitchToMode "search"; }
            }
            renametab {
                bind "esc" { UndoRenameTab; SwitchToMode "tab"; }
            }
            shared_among "renametab" "renamepane" {
                bind "Ctrl c" { SwitchToMode "normal"; }
            }
            renamepane {
                bind "esc" { UndoRenamePane; SwitchToMode "pane"; }
            }
            tmux {
                bind "left" { MoveFocus "left"; SwitchToMode "normal"; }
                bind "down" { MoveFocus "down"; SwitchToMode "normal"; }
                bind "up" { MoveFocus "up"; SwitchToMode "normal"; }
                bind "right" { MoveFocus "right"; SwitchToMode "normal"; }
                bind "h" { MoveFocus "left"; SwitchToMode "normal"; }
                bind "j" { MoveFocus "down"; SwitchToMode "normal"; }
                bind "k" { MoveFocus "up"; SwitchToMode "normal"; }
                bind "l" { MoveFocus "right"; SwitchToMode "normal"; }
                bind "space" { NextSwapLayout; }
                bind "\"" { NewPane "down"; SwitchToMode "normal"; }
                bind "%" { NewPane "right"; SwitchToMode "normal"; }
                bind "," { SwitchToMode "renametab"; }
                bind "[" { SwitchToMode "scroll"; }
                bind "Ctrl b" { Write 2; SwitchToMode "normal"; }
                bind "c" { NewTab; SwitchToMode "normal"; }
                bind "n" { GoToNextTab; SwitchToMode "normal"; }
                bind "o" { FocusNextPane; }
                bind "p" { GoToPreviousTab; SwitchToMode "normal"; }
                bind "z" { ToggleFocusFullscreen; SwitchToMode "normal"; }
            }
        }
      '';
    };

    config.constructFiles."layouts/default.kdl" = {
      relPath = "etc/zellij/layouts/default.kdl";
      content = ''
        layout {
            pane size=1 borderless=true {
                plugin location="file:${pkgs.zellijPlugins.zjstatus}" {
                    format_left "{mode}#[fg=#cba6f7] {session} #[fg=#6c7086]|#[fg=#a6e3a1] {tabs}"
                    mode_normal "#[bg=#a6e3a1,fg=#1e1e2e,bold] NORMAL "
                    mode_locked "#[bg=#f38ba8,fg=#1e1e2e,bold] LOCKED "
                    mode_pane "#[bg=#89b4fa,fg=#1e1e2e,bold] PANE "
                    mode_tab "#[bg=#89dceb,fg=#1e1e2e,bold] TAB "
                    mode_resize "#[bg=#fab387,fg=#1e1e2e,bold] RESIZE "
                    mode_scroll "#[bg=#f9e2af,fg=#1e1e2e,bold] SCROLL "
                    mode_search "#[bg=#f9e2af,fg=#1e1e2e,bold] SEARCH "
                    mode_session "#[bg=#cba6f7,fg=#1e1e2e,bold] SESSION "
                    mode_move "#[bg=#fab387,fg=#1e1e2e,bold] MOVE "
                    mode_tmux "#[bg=#f38ba8,fg=#1e1e2e,bold] TMUX "
                    mode_default_to_mode "normal"
                    tab_normal "#[fg=#6c7086] {index} {name} "
                    tab_active "#[fg=#cba6f7,bold] {index} {name} "
                    tab_fullscreen "#[fg=#f38ba8,bold] {index} {name} [] "
                    tab_sync "#[fg=#f9e2af,bold] {index} {name} <> "
                }
            }
            pane split_direction="horizontal"
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
      '';
    };

    config.constructFiles."layouts/dev.kdl" = {
      relPath = "etc/zellij/layouts/dev.kdl";
      content = ''
        layout {
            pane size=1 borderless=true {
                plugin location="file:${pkgs.zellijPlugins.zjstatus}" {
                    format_left "{mode}#[fg=#cba6f7] {session} #[fg=#6c7086]|#[fg=#a6e3a1] {tabs}"
                    format_right "#[fg=#6c7086]| #[fg=#cba6f7]{git_branch} {git_ahead_behind} #[fg=#6c7086]| #[fg=#89b4fa]{datetime}"
                    mode_normal "#[bg=#a6e3a1,fg=#1e1e2e,bold] NORMAL "
                    mode_locked "#[bg=#f38ba8,fg=#1e1e2e,bold] LOCKED "
                    mode_pane "#[bg=#89b4fa,fg=#1e1e2e,bold] PANE "
                    mode_tab "#[bg=#89dceb,fg=#1e1e2e,bold] TAB "
                    mode_resize "#[bg=#fab387,fg=#1e1e2e,bold] RESIZE "
                    mode_scroll "#[bg=#f9e2af,fg=#1e1e2e,bold] SCROLL "
                    mode_search "#[bg=#f9e2af,fg=#1e1e2e,bold] SEARCH "
                    mode_session "#[bg=#cba6f7,fg=#1e1e2e,bold] SESSION "
                    mode_move "#[bg=#fab387,fg=#1e1e2e,bold] MOVE "
                    mode_tmux "#[bg=#f38ba8,fg=#1e1e2e,bold] TMUX "
                    mode_default_to_mode "normal"
                    tab_normal "#[fg=#6c7086] {index} {name} "
                    tab_active "#[fg=#cba6f7,bold] {index} {name} "
                    tab_fullscreen "#[fg=#f38ba8,bold] {index} {name} [] "
                    tab_sync "#[fg=#f9e2af,bold] {index} {name} <> "
                }
            }
            pane split_direction="vertical" {
                pane size="70%" command="hx" {
                    args "."
                }
                pane size="30%" command="bacon" {
                    args "clippy"
                }
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
      '';
    };

    config.constructFiles."themes/cyber-noir-m.kdl" = {
      relPath = "etc/zellij/themes/cyber-noir-m.kdl";
      content = ''

        themes {
            cyber-noir-m {
                text_unselected {
                    base 229 233 240
                    background 59 66 82
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 163 190 140
                    emphasis_3 180 142 173
                }
                text_selected {
                    base 229 233 240
                    background 59 66 82
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 163 190 140
                    emphasis_3 180 142 173
                }
                ribbon_selected {
                    base 59 66 82
                    background 163 190 140
                    emphasis_0 191 97 106
                    emphasis_1 208 135 112
                    emphasis_2 180 142 173
                    emphasis_3 129 161 193
                }
                ribbon_unselected {
                    base 59 66 82
                    background 216 222 233
                    emphasis_0 191 97 106
                    emphasis_1 229 233 240
                    emphasis_2 129 161 193
                    emphasis_3 180 142 173
                }
                table_title {
                    base 163 190 140
                    background 0
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 163 190 140
                    emphasis_3 180 142 173
                }
                table_cell_selected {
                    base 229 233 240
                    background 46 52 64
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 163 190 140
                    emphasis_3 180 142 173
                }
                table_cell_unselected {
                    base 229 233 240
                    background 59 66 82
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 163 190 140
                    emphasis_3 180 142 173
                }
                list_selected {
                    base 229 233 240
                    background 46 52 64
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 163 190 140
                    emphasis_3 180 142 173
                }
                list_unselected {
                    base 229 233 240
                    background 59 66 82
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 163 190 140
                    emphasis_3 180 142 173
                }
                frame_selected {
                    base 196 167 231
                    background 0
                    emphasis_0 208 135 112
                    emphasis_1 136 192 208
                    emphasis_2 180 142 173
                    emphasis_3 0
                }
                frame_highlight {
                    base 196 167 231
                    background 0
                    emphasis_0 180 142 173
                    emphasis_1 208 135 112
                    emphasis_2 208 135 112
                    emphasis_3 208 135 112
                }
                exit_code_success {
                    base 163 190 140
                    background 0
                    emphasis_0 136 192 208
                    emphasis_1 59 66 82
                    emphasis_2 180 142 173
                    emphasis_3 129 161 193
                }
                exit_code_error {
                    base 191 97 106
                    background 0
                    emphasis_0 235 203 139
                    emphasis_1 0
                    emphasis_2 0
                    emphasis_3 0
                }
                multiplayer_user_colors {
                    player_1 180 142 173
                    player_2 129 161 193
                    player_3 0
                    player_4 235 203 139
                    player_5 136 192 208
                    player_6 0
                    player_7 191 97 106
                    player_8 0
                    player_9 0
                    player_10 0
                }
            }
        }
      '';
    };

    config.env.ZELLIJ_CONFIG_FILE = config.constructFiles."config.kdl".path;
    config.env.ZELLIJ_CONFIG_DIR =
      builtins.dirOf (builtins.dirOf config.constructFiles."config.kdl".path);
  };

  perSystem = { pkgs, ... }: {
    packages.zellij = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      imports = [ self.wrappersModules.zellij ];
    };
  };
}
