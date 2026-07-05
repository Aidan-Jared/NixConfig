
{ self, inputs, ... }: {
  flake.homeModules.herdr = { pkgs, lib, ... }: {

    home.packages = [
      inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.herdr ={
      enable = true;
      package = inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;

      settings = {
        update.channel = "preview";
        keys = {
          prefix = "ctrl+b";

          # Prefix-mode actions
          help = "prefix+?";
          settings = "prefix+s";
          detach = "prefix+q";
          reload_config = "prefix+shift+r";
          open_notification_target = "prefix+o";
          workspace_picker = "prefix+w";
          goto = "prefix+g";
          new_workspace = "prefix+shift+n";
          new_worktree = "prefix+shift+g";
          open_worktree = "";    # optional, unset by default
          remove_worktree = "";  # optional, unset by default; opens confirmation
          rename_workspace = "prefix+shift+w";
          close_workspace = "prefix+shift+d";
          previous_workspace = ""; # optional, unset by default
          next_workspace = "";     # optional, unset by default
          remote_image_paste = "ctrl+v"; # only active in herdr --remote; empty disables raw-key image paste
          new_tab = "prefix+c";
          rename_tab = "prefix+shift+t";
          previous_tab = "prefix+p";
          next_tab = "prefix+n";
          switch_tab = "prefix+1..9";
          switch_workspace = "";   # optional indexed binding, e.g. "prefix+shift+1..9";
          close_tab = "prefix+shift+x";
          rename_pane = "prefix+shift+p";
          edit_scrollback = "prefix+e";
          focus_pane_left = "prefix+h";
          focus_pane_down = "prefix+j";
          focus_pane_up = "prefix+k";
          focus_pane_right = "prefix+l";
          cycle_pane_next = "prefix+tab";
          cycle_pane_previous = "prefix+shift+tab";
          last_pane = "";          # optional, unset by default; bind e.g. "prefix+tab"; for global back-and-forth
          split_vertical = "prefix+v";
          split_horizontal = "prefix+minus";
          close_pane = "prefix+x";
          zoom = "prefix+z";       # legacy alias: fullscreen
          resize_mode = "prefix+r";
          toggle_sidebar = "prefix+b";

          # Navigate-mode movement. These local shortcuts win while navigate mode is open.
          # They are independent from focus_pane_*. Do not include prefix+, esc, enter, tab, or 1..9 here.
          navigate_workspace_up = "up";
          navigate_workspace_down = "down";
          navigate_pane_left = "h";      # left arrow always focuses the pane to the left
          navigate_pane_down = "j";
          navigate_pane_up = "k";
          navigate_pane_right = "l";     # right arrow always focuses the pane to the right
        };
        ui = {
          sidebar_width = 26;

          # Minimum sidebar width when expanded (columns)
          sidebar_min_width = 18;

          # Maximum sidebar width when expanded (columns)
          sidebar_max_width = 36;

          # Collapsed sidebar presentation: "compact" keeps the narrow status rail, "hidden" uses zero width.
          sidebar_collapsed_mode = "compact";

          # Terminal width at or below which Herdr uses the mobile single-column layout.
          # Increase this for foldables, tablets, or wide phone terminals.
          mobile_width_threshold = 64;

          # Capture mouse input for Herdr's mouse UI.
          # Set false to let the terminal handle normal clicks, such as Cmd-clicking URLs.
          # Pane apps like lazygit and btop can still receive mouse when they request it.
          mouse_capture = true;

          # Optional modifier that forwards right-click hold/drag gestures to pane apps instead of opening Herdr's pane menu.
          # Empty/off disables this. Shift is intentionally unsupported because terminals commonly reserve Shift+mouse.
          right_click_passthrough_modifier = "";

          # Force a full redraw when the outer terminal regains focus.
          # Set false to reduce visible flashing when switching back to Herdr.
          # Trade-off: rare host terminal surface corruption may persist until the next full redraw.
          redraw_on_focus_gained = true;

          # Pane scrollback lines to scroll per mouse wheel notch.
          mouse_scroll_lines = 3;

          # Ask for confirmation before closing a workspace
          confirm_close = true;

          # Ask for a tab name before creating a new tab.
          # Set false to create tabs immediately with generated names.
          prompt_new_tab_name = true;

          # Draw borders around split panes.
          pane_borders = false;

          # Keep split panes visually separated instead of sharing divider borders.
          pane_gaps = true;

          # Show detected/reported agent labels in split pane borders when no manual pane name is set.
          show_agent_labels_on_pane_borders = false;

          # Agent panel ordering: "spaces" (grouped by space) or "priority" (attention queue).
          # "workspaces" is accepted as an alias for "spaces".
          agent_panel_sort = "spaces";


          # Accent color for highlights, borders, and navigation UI.
          # Accepts: hex (#89b4fa), named colors (cyan, blue, magenta), or rgb(r,g,b)
          # accent = "cyan"
        };

        experimental.pane_history = true;
      };
    };
  };
}
