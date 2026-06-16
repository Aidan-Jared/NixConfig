{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # yaziPlugins.starship
    # yaziPlugins.ouch
    # yaziPlugins.piper
    # yaziPlugins.duckdb
    # yaziPlugins.full-border
    # yaziPlugins.git
    # yaziPlugins.gitui
    # yaziPlugins.glow
    # yaziPlugins.mount
    # yaziPlugins.office
    # duckdb
  ];

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    shellWrapperName = "y";

    # flavors = {
    #   rose-pine = rose-pine-flavor;
    #   catppuccin-mocha = catppuccin-mocha-flavor;
    # };

    package = pkgs.yazi;

    settings = {
      mgr = {
        ratio          = [ 1 4 3 ];
        sort_by        = "alphabetical";
        sort_sensitive = false;
        sort_reverse   = false;
        sort_dir_first = true;
        sort_translit  = false;
        linemode       = "none";
        show_hidden    = false;
        show_symlink   = true;
        scrolloff      = 5;
        mouse_events   = [ "click" "scroll" ];
        title_format   = "Yazi: {cwd}";
      };

      preview = {
        wrap           = "no";
        tab_size       = 2;
        max_width      = 600;
        max_height     = 900;
        cache_dir      = "";
        image_delay    = 30;
        image_filter   = "triangle";
        image_quality  = 75;
        ueberzug_scale = 1;
        ueberzug_offset = [ 0 0 0 0 ];
        image_protocol = "kitty";
      };

      opener = {
        edit = [
          { run = "\${EDITOR:-hx} %s"; desc = "helix"; for = "unix"; block = true; }
          { run = "zellij action new-tab -- \${EDITOR:-hx} %s"; desc = "helix (zellij tab)"; for = "unix"; }
          { run = "zellij action new-pane -- \${EDITOR:-hx} %s"; desc = "helix (zellij pane)"; for = "unix"; }
          { run = "zed %s"; desc = "zed"; for = "unix"; block = true; }
          { run = "code %s"; desc = "vscode"; for = "unix"; block = true; }
        ];
        play = [
          { run = "xdg-open %s1"; desc = "Play"; for = "linux"; orphan = true; }
          { run = "mediainfo %s1; echo 'Press enter to exit'; read _"; block = true; desc = "Show media info"; for = "unix"; }
        ];
        open = [
          { run = "xdg-open %s1"; desc = "Open"; for = "linux"; }
        ];
        reveal = [
          { run = "xdg-open %d1"; desc = "Reveal"; for = "linux"; }
          { run = "clear; exiftool %s1; echo 'Press enter to exit'; read _"; desc = "Show EXIF"; for = "unix"; block = true; }
        ];
        extract = [
          { run = "ya pub extract --list %s"; desc = "Extract here"; }
        ];
        download = [
          { run = "ya emit download --open %S"; desc = "Download and open"; }
          { run = "ya emit download %S"; desc = "Download"; }
        ];
        folder = [
          { run = ''zed "$@"''; block = false; desc = "Zed"; }
          { run = ''code "$@"''; block = false; desc = "VSCode"; }
        ];
      };

      open.rules = [
        { url = "*/"; use = [ "edit" "open" "reveal" ]; }
        { mime = "text/*"; use = [ "edit" "reveal" ]; }
        { mime = "image/*"; use = [ "open" "reveal" ]; }
        { mime = "{audio,video}/*"; use = [ "play" "reveal" ]; }
        { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}"; use = [ "extract" "reveal" ]; }
        { mime = "application/{json,ndjson}"; use = [ "edit" "reveal" ]; }
        { mime = "*/javascript"; use = [ "edit" "reveal" ]; }
        { mime = "inode/empty"; use = [ "edit" "reveal" ]; }
        { mime = "vfs/{absent,stale}"; use = "download"; }
        { mime = "inode/directory"; use = "folder"; }
        { url = "*"; use = [ "open" "reveal" ]; }
      ];

      tasks = {
        micro_workers    = 10;
        macro_workers    = 10;
        bizarre_retry    = 3;
        image_alloc      = 536870912;
        image_bound      = [ 10000 10000 ];
        suppress_preload = false;
      };

      input = {
        cursor_blink = false;
        cd_title     = "Change directory:";
        cd_origin    = "top-center";
        cd_offset    = [ 0 2 50 3 ];
        create_title  = [ "Create:" "Create (dir):" ];
        create_origin = "top-center";
        create_offset = [ 0 2 50 3 ];
        rename_title  = "Rename:";
        rename_origin = "hovered";
        rename_offset = [ 0 1 50 3 ];
        filter_title  = "Filter:";
        filter_origin = "top-center";
        filter_offset = [ 0 2 50 3 ];
        find_title    = [ "Find next:" "Find previous:" ];
        find_origin   = "top-center";
        find_offset   = [ 0 2 50 3 ];
        search_title  = "Search via {n}:";
        search_origin = "top-center";
        search_offset = [ 0 2 50 3 ];
        shell_title   = [ "Shell:" "Shell (block):" ];
        shell_origin  = "top-center";
        shell_offset  = [ 0 2 50 3 ];
      };

      confirm = {
        trash_title    = "Trash {n} selected file{s}?";
        trash_origin   = "center";
        trash_offset   = [ 0 0 70 20 ];
        delete_title   = "Permanently delete {n} selected file{s}?";
        delete_origin  = "center";
        delete_offset  = [ 0 0 70 20 ];
        overwrite_title  = "Overwrite file?";
        overwrite_body   = "Will overwrite the following file:";
        overwrite_origin = "center";
        overwrite_offset = [ 0 0 50 15 ];
        quit_title  = "Quit?";
        quit_body   = "There are unfinished tasks, quit anyway?\n(Open task manager with default key 'w')";
        quit_origin = "center";
        quit_offset = [ 0 0 50 15 ];
      };

      pick = {
        open_title  = "Open with:";
        open_origin = "hovered";
        open_offset = [ 0 1 50 7 ];
      };

      which = {
        sort_by        = "none";
        sort_sensitive = false;
        sort_reverse   = false;
        sort_translit  = false;
      };
    };

    keymap = {
      mgr.keymap = [
        { on = "<Esc>";   run = "escape";             desc = "Exit visual mode, clear selection, or cancel search"; }
        { on = "<C-[>";   run = "escape";             desc = "Exit visual mode, clear selection, or cancel search"; }
        { on = "q";       run = "quit";               desc = "Quit the process"; }
        { on = "Q";       run = "quit --no-cwd-file"; desc = "Quit without outputting cwd-file"; }
        { on = "<C-c>";   run = "close";              desc = "Close the current tab, or quit if it's last"; }
        { on = "<C-z>";   run = "suspend";            desc = "Suspend the process"; }
        { on = "k";       run = "arrow prev";         desc = "Previous file"; }
        { on = "j";       run = "arrow next";         desc = "Next file"; }
        { on = "<Up>";    run = "arrow prev";         desc = "Previous file"; }
        { on = "<Down>";  run = "arrow next";         desc = "Next file"; }
        { on = "<C-u>";   run = "arrow -50%";         desc = "Move cursor up half page"; }
        { on = "<C-d>";   run = "arrow 50%";          desc = "Move cursor down half page"; }
        { on = "<C-b>";   run = "arrow -100%";        desc = "Move cursor up one page"; }
        { on = "<C-f>";   run = "arrow 100%";         desc = "Move cursor down one page"; }
        { on = [ "g" "g" ]; run = "arrow top";       desc = "Go to top"; }
        { on = "G";       run = "arrow bot";          desc = "Go to bottom"; }
        { on = "h";       run = "leave";              desc = "Back to the parent directory"; }
        { on = "l";       run = "enter";              desc = "Enter the child directory"; }
        { on = "<Left>";  run = "leave";              desc = "Back to the parent directory"; }
        { on = "<Right>"; run = "enter";              desc = "Enter the child directory"; }
        { on = "H";       run = "back";               desc = "Back to previous directory"; }
        { on = "L";       run = "forward";            desc = "Forward to next directory"; }
        { on = "<Space>"; run = [ "toggle" "arrow 1" ]; desc = "Toggle the current selection state"; }
        { on = "<C-a>";   run = "toggle_all --state=on"; desc = "Select all files"; }
        { on = "<C-r>";   run = "toggle_all";         desc = "Invert selection of all files"; }
        { on = "v";       run = "visual_mode";        desc = "Enter visual mode (selection mode)"; }
        { on = "V";       run = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }
        { on = "K";       run = "seek -5";            desc = "Seek up 5 units in the preview"; }
        { on = "J";       run = "seek 5";             desc = "Seek down 5 units in the preview"; }
        { on = "<Tab>";   run = "spot";               desc = "Spot hovered file"; }
        { on = "o";       run = "open";               desc = "Open selected files"; }
        { on = "O";       run = "open --interactive"; desc = "Open selected files interactively"; }
        { on = "<Enter>"; run = "open";               desc = "Open selected files"; }
        { on = "y";       run = "yank";               desc = "Yank selected files (copy)"; }
        { on = "x";       run = "yank --cut";         desc = "Yank selected files (cut)"; }
        { on = "p";       run = "paste";              desc = "Paste yanked files"; }
        { on = "P";       run = "paste --force";      desc = "Paste yanked files (overwrite if the destination exists)"; }
        { on = "-";       run = "link";               desc = "Symlink the absolute path of yanked files"; }
        { on = "_";       run = "link --relative";    desc = "Symlink the relative path of yanked files"; }
        { on = "Y";       run = "unyank";             desc = "Cancel the yank status"; }
        { on = "X";       run = "unyank";             desc = "Cancel the yank status"; }
        { on = "d";       run = "remove";             desc = "Trash selected files"; }
        { on = "D";       run = "remove --permanently"; desc = "Permanently delete selected files"; }
        { on = "a";       run = "create";             desc = "Create a file (ends with / for directories)"; }
        { on = "r";       run = "rename --cursor=before_ext"; desc = "Rename selected file(s)"; }
        { on = ";";       run = "shell --interactive"; desc = "Run a shell command"; }
        { on = ":";       run = "shell --block --interactive"; desc = "Run a shell command (block until finishes)"; }
        { on = ".";       run = "hidden toggle";      desc = "Toggle the visibility of hidden files"; }
        { on = "s";       run = "search --via=fd";    desc = "Search files by name via fd"; }
        { on = "S";       run = "search --via=rg";    desc = "Search files by content via ripgrep"; }
        { on = "<C-s>";   run = "escape --search";    desc = "Cancel the ongoing search"; }
        { on = "z";       run = "plugin fzf";         desc = "Jump to a file/directory via fzf"; }
        { on = "Z";       run = "plugin zoxide";      desc = "Jump to a directory via zoxide"; }
        { on = [ "m" "s" ]; run = "linemode size";        desc = "Linemode: size"; }
        { on = [ "m" "p" ]; run = "linemode permissions"; desc = "Linemode: permissions"; }
        { on = [ "m" "b" ]; run = "linemode btime";       desc = "Linemode: btime"; }
        { on = [ "m" "m" ]; run = "linemode mtime";       desc = "Linemode: mtime"; }
        { on = [ "m" "o" ]; run = "linemode owner";       desc = "Linemode: owner"; }
        { on = [ "m" "n" ]; run = "linemode none";        desc = "Linemode: none"; }
        { on = [ "c" "c" ]; run = "copy path";            desc = "Copy the file path"; }
        { on = [ "c" "d" ]; run = "copy dirname";         desc = "Copy the directory path"; }
        { on = [ "c" "f" ]; run = "copy filename";        desc = "Copy the filename"; }
        { on = [ "c" "n" ]; run = "copy name_without_ext"; desc = "Copy the filename without extension"; }
        { on = "f";       run = "filter --smart";     desc = "Filter files"; }
        { on = "/";       run = "find --smart";       desc = "Find next file"; }
        { on = "?";       run = "find --previous --smart"; desc = "Find previous file"; }
        { on = "n";       run = "find_arrow";         desc = "Next found"; }
        { on = "N";       run = "find_arrow --previous"; desc = "Previous found"; }
        { on = [ "," "m" ]; run = [ "sort mtime --reverse=no"  "linemode mtime" ]; desc = "Sort by modified time"; }
        { on = [ "," "M" ]; run = [ "sort mtime --reverse=yes" "linemode mtime" ]; desc = "Sort by modified time (reverse)"; }
        { on = [ "," "a" ]; run = "sort alphabetical --reverse=no";  desc = "Sort alphabetically"; }
        { on = [ "," "A" ]; run = "sort alphabetical --reverse=yes"; desc = "Sort alphabetically (reverse)"; }
        { on = [ "," "s" ]; run = [ "sort size --reverse=no"  "linemode size" ]; desc = "Sort by size"; }
        { on = [ "," "S" ]; run = [ "sort size --reverse=yes" "linemode size" ]; desc = "Sort by size (reverse)"; }
        { on = [ "," "r" ]; run = "sort random --reverse=no"; desc = "Sort randomly"; }
        { on = [ "g" "h" ];       run = "cd ~";             desc = "Go home"; }
        { on = [ "g" "c" ];       run = "cd ~/.config";     desc = "Go ~/.config"; }
        { on = [ "g" "d" ];       run = "cd ~/Downloads";   desc = "Go ~/Downloads"; }
        { on = [ "g" "<Space>" ]; run = "cd --interactive"; desc = "Jump interactively"; }
        { on = [ "g" "f" ];       run = "follow";           desc = "Follow hovered symlink"; }
        { on = "t"; run = "tab_create --current"; desc = "Create a new tab with CWD"; }
        { on = "1"; run = "tab_switch 0"; desc = "Switch to first tab"; }
        { on = "2"; run = "tab_switch 1"; desc = "Switch to second tab"; }
        { on = "3"; run = "tab_switch 2"; desc = "Switch to third tab"; }
        { on = "4"; run = "tab_switch 3"; desc = "Switch to fourth tab"; }
        { on = "5"; run = "tab_switch 4"; desc = "Switch to fifth tab"; }
        { on = "["; run = "tab_switch -1 --relative"; desc = "Switch to previous tab"; }
        { on = "]"; run = "tab_switch 1 --relative";  desc = "Switch to next tab"; }
        { on = "{"; run = "tab_swap -1"; desc = "Swap current tab with previous tab"; }
        { on = "}"; run = "tab_swap 1";  desc = "Swap current tab with next tab"; }
        { on = "w";    run = "tasks:show"; desc = "Show task manager"; }
        { on = "~";    run = "help"; desc = "Open help"; }
        { on = "<F1>"; run = "help"; desc = "Open help"; }
      ];

      tasks.keymap = [
        { on = "<Esc>";   run = "close"; desc = "Close task manager"; }
        { on = "<C-[>";   run = "close"; desc = "Close task manager"; }
        { on = "<C-c>";   run = "close"; desc = "Close task manager"; }
        { on = "w";       run = "close"; desc = "Close task manager"; }
        { on = "k";       run = "arrow prev"; desc = "Previous task"; }
        { on = "j";       run = "arrow next"; desc = "Next task"; }
        { on = "<Up>";    run = "arrow prev"; desc = "Previous task"; }
        { on = "<Down>";  run = "arrow next"; desc = "Next task"; }
        { on = "<Enter>"; run = "inspect"; desc = "Inspect the task"; }
        { on = "x";       run = "cancel";  desc = "Cancel the task"; }
        { on = "~";    run = "help"; desc = "Open help"; }
        { on = "<F1>"; run = "help"; desc = "Open help"; }
      ];

      spot.keymap = [
        { on = "<Esc>"; run = "close"; desc = "Close the spot"; }
        { on = "<C-[>"; run = "close"; desc = "Close the spot"; }
        { on = "<C-c>"; run = "close"; desc = "Close the spot"; }
        { on = "<Tab>"; run = "close"; desc = "Close the spot"; }
        { on = "k"; run = "arrow prev"; desc = "Previous line"; }
        { on = "j"; run = "arrow next"; desc = "Next line"; }
        { on = "h"; run = "swipe prev"; desc = "Swipe to previous file"; }
        { on = "l"; run = "swipe next"; desc = "Swipe to next file"; }
        { on = "<Up>";    run = "arrow prev"; desc = "Previous line"; }
        { on = "<Down>";  run = "arrow next"; desc = "Next line"; }
        { on = "<Left>";  run = "swipe prev"; desc = "Swipe to previous file"; }
        { on = "<Right>"; run = "swipe next"; desc = "Swipe to next file"; }
        { on = [ "c" "c" ]; run = "copy cell"; desc = "Copy selected cell"; }
        { on = "~";    run = "help"; desc = "Open help"; }
        { on = "<F1>"; run = "help"; desc = "Open help"; }
      ];

      pick.keymap = [
        { on = "<Esc>";   run = "close";          desc = "Cancel pick"; }
        { on = "<C-[>";   run = "close";          desc = "Cancel pick"; }
        { on = "<C-c>";   run = "close";          desc = "Cancel pick"; }
        { on = "<Enter>"; run = "close --submit"; desc = "Submit the pick"; }
        { on = "k"; run = "arrow prev"; desc = "Previous option"; }
        { on = "j"; run = "arrow next"; desc = "Next option"; }
        { on = "<Up>";   run = "arrow prev"; desc = "Previous option"; }
        { on = "<Down>"; run = "arrow next"; desc = "Next option"; }
        { on = "~";    run = "help"; desc = "Open help"; }
        { on = "<F1>"; run = "help"; desc = "Open help"; }
      ];

      input.keymap = [
        { on = "<C-c>";   run = "close";          desc = "Cancel input"; }
        { on = "<Enter>"; run = "close --submit"; desc = "Submit input"; }
        { on = "<Esc>";   run = "escape";         desc = "Back to normal mode, or cancel input"; }
        { on = "<C-[>";   run = "escape";         desc = "Back to normal mode, or cancel input"; }
        { on = "i"; run = "insert";                        desc = "Enter insert mode"; }
        { on = "a"; run = "insert --append";               desc = "Enter append mode"; }
        { on = "v"; run = "visual";                        desc = "Enter visual mode"; }
        { on = "r"; run = "replace";                       desc = "Replace a single character"; }
        { on = "h";       run = "move -1"; desc = "Move back a character"; }
        { on = "l";       run = "move 1";  desc = "Move forward a character"; }
        { on = "<Left>";  run = "move -1"; desc = "Move back a character"; }
        { on = "<Right>"; run = "move 1";  desc = "Move forward a character"; }
        { on = "b"; run = "backward";     desc = "Move back to the start of the current or previous word"; }
        { on = "w"; run = "forward";      desc = "Move forward to the start of the next word"; }
        { on = "e"; run = "forward --end-of-word"; desc = "Move forward to the end of the current or next word"; }
        { on = "0";      run = "move bol";        desc = "Move to the BOL"; }
        { on = "$";      run = "move eol";        desc = "Move to the EOL"; }
        { on = "<Home>"; run = "move bol";        desc = "Move to the BOL"; }
        { on = "<End>";  run = "move eol";        desc = "Move to the EOL"; }
        { on = "<Backspace>"; run = "backspace";         desc = "Delete the character before the cursor"; }
        { on = "<Delete>";    run = "backspace --under"; desc = "Delete the character under the cursor"; }
        { on = "<C-u>"; run = "kill bol";      desc = "Kill backwards to the BOL"; }
        { on = "<C-k>"; run = "kill eol";      desc = "Kill forwards to the EOL"; }
        { on = "<C-w>"; run = "kill backward"; desc = "Kill backwards to the start of the current word"; }
        { on = "d"; run = "delete --cut";              desc = "Cut selected characters"; }
        { on = "y"; run = "yank";                      desc = "Copy selected characters"; }
        { on = "p"; run = "paste";                     desc = "Paste copied characters after the cursor"; }
        { on = "u";     run = [ "undo" "casefy lower" ]; desc = "Undo, or lowercase if in visual mode"; }
        { on = "U";     run = "casefy upper";            desc = "Uppercase"; }
        { on = "<C-r>"; run = "redo";                    desc = "Redo the last operation"; }
        { on = "~";    run = "help"; desc = "Open help"; }
        { on = "<F1>"; run = "help"; desc = "Open help"; }
      ];

      confirm.keymap = [
        { on = "<Esc>";   run = "close";          desc = "Cancel the confirm"; }
        { on = "<C-[>";   run = "close";          desc = "Cancel the confirm"; }
        { on = "<C-c>";   run = "close";          desc = "Cancel the confirm"; }
        { on = "<Enter>"; run = "close --submit"; desc = "Submit the confirm"; }
        { on = "n"; run = "close";          desc = "Cancel the confirm"; }
        { on = "y"; run = "close --submit"; desc = "Submit the confirm"; }
        { on = "k"; run = "arrow prev"; desc = "Previous line"; }
        { on = "j"; run = "arrow next"; desc = "Next line"; }
        { on = "~";    run = "help"; desc = "Open help"; }
        { on = "<F1>"; run = "help"; desc = "Open help"; }
      ];

      help.keymap = [
        { on = "<Esc>"; run = "escape"; desc = "Clear the filter, or hide the help"; }
        { on = "<C-[>"; run = "escape"; desc = "Clear the filter, or hide the help"; }
        { on = "<C-c>"; run = "close";  desc = "Hide the help"; }
        { on = "k"; run = "arrow prev"; desc = "Previous line"; }
        { on = "j"; run = "arrow next"; desc = "Next line"; }
        { on = "<Up>";   run = "arrow prev"; desc = "Previous line"; }
        { on = "<Down>"; run = "arrow next"; desc = "Next line"; }
        { on = "f"; run = "filter"; desc = "Filter help items"; }
      ];
    };

    # theme = {
    #   flavor = {
    #     # dark  = "rose-pine";
    #     # light = "";
    #   };

      # mgr = {
      #   cwd = { fg = "cyan"; };
      #   find_keyword  = { fg = "yellow"; bold = true; italic = true; underline = true; };
      #   find_position = { fg = "magenta"; bg = "reset"; bold = true; italic = true; };
      #   symlink_target   = { italic = true; };
      #   marker_copied    = { fg = "lightgreen";  bg = "lightgreen"; };
      #   marker_cut       = { fg = "lightred";    bg = "lightred"; };
      #   marker_marked    = { fg = "lightcyan";   bg = "lightcyan"; };
      #   marker_selected  = { fg = "lightyellow"; bg = "lightyellow"; };
      #   count_copied     = { fg = "white"; bg = "green"; };
      #   count_cut        = { fg = "white"; bg = "red"; };
      #   count_selected   = { fg = "black"; bg = "yellow"; };
      #   border_symbol = "│";
      #   border_style  = { fg = "gray"; };
      # };

      # tabs = {
      #   active   = { bg = "blue"; bold = true; };
      #   inactive = { fg = "blue"; bg = "gray"; };
      #   sep_inner = { open = ""; close = ""; };
      #   sep_outer = { open = ""; close = ""; };
      # };

      # mode = {
      #   normal_main = { bg = "blue"; bold = true; };
      #   normal_alt  = { fg = "blue"; bg = "gray"; };
      #   select_main = { bg = "red"; bold = true; };
      #   select_alt  = { fg = "red"; bg = "gray"; };
      #   unset_main  = { bg = "red"; bold = true; };
      #   unset_alt   = { fg = "red"; bg = "gray"; };
      # };

      # status = {
      #   sep_left  = { open = ""; close = ""; };
      #   sep_right = { open = ""; close = ""; };
      #   perm_sep   = { fg = "darkgray"; };
      #   perm_type  = { fg = "green"; };
      #   perm_read  = { fg = "yellow"; };
      #   perm_write = { fg = "red"; };
      #   perm_exec  = { fg = "cyan"; };
      #   progress_label  = { bold = true; };
      #   progress_normal = { fg = "green"; bg = "black"; };
      #   progress_error  = { fg = "yellow"; bg = "red"; };
      # };
    # };
  };


   # programs.starship = {
   #   enable = true;
   # };
   # programs.ouch = {
   #   enable = true;
   # };
   # programs.piper = {
   #   enable = true;
   # };
   # programs.duckdb = {
   #   enable = true;
   # };
   # programs.full-border = {
   #   enable = true;
   # };
   # programs.git = {
   #   enable = true;
   # };
   # programs.gitui = {
   #   enable = true;
   # };
   # programs.glow = {
   #   enable = true;
   # };
   # programs.mount = {
   #   enable = true;
   # };
   # programs.office = {
   #   enable = true;
   # };
}
