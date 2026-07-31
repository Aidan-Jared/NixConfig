{ inputs, self, ... }: 
let
  mangowcModule = { config, lib, pkgs, ... }: let
    wayleExe = lib.getExe pkgs.wayle;
    swaylock = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.swaylock;
    fuzzelExe = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.fuzzel;
    fuzzelDmenu = prompt: "${fuzzelExe} --dmenu --prompt \"${prompt}\"";
    # swayosd = lib.getExe ;
  in {
    options.terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
    };

    config = {
      package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
      
        # ${wayleExe} panel start
      autostart_sh = ''
        waybar &
        ${(lib.getExe (
           pkgs.writeShellScriptBin "wallpaper"
           "${lib.getExe pkgs.swaybg} -i ${self.wallpaper} -m fill"
         ))} &
        wl-paste --watch ${lib.getExe pkgs.cliphist} store &

        swayosd-server
      '';

      settings = {
        # Window effects
        blur = 1;
        blur_layer = 0;
        blur_optimized = 1;
        blur_params = {
          radius = 5;
          num_passes = 2;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.2;
        };
        border_radius = 6;
        no_radius_when_single = 0;
        focused_opacity = 0.9;
        unfocused_opacity = 0.6;

        # Shadows
        shadows = 0;
        layer_shadows = 0;
        shadow_only_floating = 1;
        shadows_size = 10;
        shadows_blur = 15;
        shadows_position_x = 0;
        shadows_position_y = 0;
        shadowscolor = "0x000000ff";

        # Animations
        animations = 1;
        layer_animations = 1;
        animation_type_open = "fade";
        animation_type_close = "fade";
        animation_fade_in = 1;
        animation_fade_out = 1;
        tag_animation_direction = 1;
        zoom_initial_ratio = 0.4;
        zoom_end_ratio = 0.8;
        fadein_begin_opacity = 0.5;
        fadeout_begin_opacity = 0.8;
        animation_duration_move = 500;
        animation_duration_open = 400;
        animation_duration_tag = 350;
        animation_duration_close = 800;
        animation_duration_focus = 0;
        gappih = 0;
        gappiv = 0;
        gappoh = 0;
        gappov = 0;
        borderpx = 1;
        no_border_when_single = 1;
        focuscolor = "0x005577ff";
        
        animation_curve = {
          open = "0.46,1.0,0.29,1";
          close = "0.08,0.92,0,1";
          move = "0.46,1.0,0.29,1";
          tag = "0.46,1.0,0.29,1";
          focus = "0.46,1.0,0.29,1";
          opafadeout = "0.5,0.5,0.5,0.5";
          opafadein = "0.46,1.0,0.29,1";
        };

        # Scroller layout
        scroller_structs = 20;
        scroller_default_proportion = 0.8;
        scroller_focus_center = 0;
        scroller_prefer_center = 0;
        edge_scroller_pointer_focus = 1;
        edge_scroller_focus_allow_speed = 0.0;
        scroller_default_proportion_single = 1.0;
        scroller_proportion_preset = "0.5,0.8,1.0";

        # Master-stack layout
        new_is_master = 0;
        default_mfact = 0.55;
        default_nmaster = 1;
        smartgaps = 0;

        # Dwindle layout
        dwindle_smart_split = 0;
        dwindle_drop_simple_split = 1;
        dwindle_manual_split = 0;
        dwindle_hsplit = 1;
        dwindle_vsplit = 1;
        dwindle_preserve_split = 0;

        # Overview
        hotarea_size = 10;
        enable_hotarea = 0;
        ov_tab_mode = 1;
        ov_no_resize = 1;
        overviewgappi = 5;
        overviewgappo = 30;

        # Misc
        axis_bind_apply_timeout = 100;
        focus_on_activate = 1;
        idleinhibit_ignore_visible = 0;
        sloppyfocus = 1;
        warpcursor = 1;
        focus_cross_monitor = 0;
        focus_cross_tag = 0;
        drag_tile_to_tile = 1;
        drag_tile_small = 1;
        enable_floating_snap = 0;
        snap_distance = 30;
        cursor_size = 24;

        # Keyboard
        repeat_rate = 25;
        repeat_delay = 600;
        numlockon = 0;
        xkb_rules_layout = "us";

        # Trackpad
        disable_trackpad = 0;
        tap_to_click = 1;
        tap_and_drag = 1;
        drag_lock = 1;
        trackpad_natural_scrolling = 0;
        disable_while_typing = 1;
        left_handed = 0;
        middle_button_emulation = 0;
        swipe_min_threshold = 1;

        # Mouse
        mouse_natural_scrolling = 0;

        # Appearance
        scratchpad_width_ratio = 0.8;
        scratchpad_height_ratio = 0.9;
        rootcolor = "0x201b14ff";
        bordercolor = "0x444444ff";
        dropcolor = "0x8FBA7C55";
        splitcolor = "0xEB441EFF";
        maximizescreencolor = "0x89aa61ff";
        urgentcolor = "0xad401fff";
        scratchpadcolor = "0x516c93ff";
        globalcolor = "0xb153a7ff";
        overlaycolor = "0x14a57cff";

        bindr = [
          "SUPER,Super_L,spawn,${fuzzelExe}"
          
        ];
        
        bind = [
          "SUPER,t,spawn,${config.terminal}"
          "SUPER,Super_L,spawn,${fuzzelExe}"
          "SUPER,Escape,spawn,${swaylock}"
          "SUPER,1,comboview,1"
          "SUPER,2,comboview,2"
          "SUPER,3,comboview,3"
          "SUPER,4,comboview,4"
          "SUPER,5,comboview,5"
          "SUPER,6,comboview,6"
          "SUPER,7,comboview,7"
          "SUPER,8,comboview,8"
          "SUPER,9,comboview,9"
          "SUPER,j,focusstack,next"
          "SUPER,k,focusstack,prev"
          "ALT,i,incnmaster,+1"
          "ALT,d,incnmaster,-1"
          "ALT,h,setmfact,-0.05"
          "ALT,l,setmfact,+0.05"
          "SUPER,Return,zoom"
          "SUPER,code:60,focusmon,right"
          "SUPER+shift,code:60,tagmon,right,0"
          "SUPER,q,killclient"
          "SUPER+SHIFT,f,togglefullscreen,"
          "SUPER,f,togglefloating,"
          "CTRL+SHIFT,k,smartmovewin,up"
          "CTRL+SHIFT,j,smartmovewin,down"
          "CTRL+SHIFT,h,smartmovewin,left"
          "CTRL+SHIFT,l,smartmovewin,right"
          "SUPER,h,focusdir,left"
          "SUPER,l,focusdir,right"
          "SUPER+SHIFT,k,exchange_client,up"
          "SUPER+SHIFT,j,exchange_client,down"
          "SUPER+SHIFT,h,exchange_client,left"
          "SUPER+SHIFT,l,exchange_client,right"
          "SUPER,i,minimized"
          "SUPER+SHIFT,i,restore_minimized"
          "SUPER,z,toggle_scratchpad"
          "SUPER,g,setlayout,tile"
          "SUPER,v,setlayout,vertical_grid"
          "SUPER,c,setlayout,spiral"
          "SUPER,n,setlayout,switch_layout"
          "SUPER,m,setlayout,monocle"
          "SUPER,s,setlayout,scroller"
          "SUPER+SHIFT,s,setlayout,vertical_scroller"
          "SUPER+CTRL,e,spawn,pcmanfm"
          "SUPER,e,spawn,ghostty -e yazi"
          "NONE,XF86AudioRaiseVolume,spawn,swayosd-client --output-volume +5"
          "NONE,XF86AudioLowerVolume,spawn,swayosd-client --output-volume -5"
          "NONE,XF86AudioMute,spawn,swayosd-client --output-volume mute-toggle"
          "NONE,XF86AudioMicMute,spawn,swayosd-client --input-volume mute-toggle"
          "NONE,XF86MonBrightnessUp,spawn,swayosd-client --brightness +5"
          "NONE,XF86MonBrightnessDown,spawn,swayosd-client --brightness -5"
          "NONE,Caps_Lock,spawn,swayosd-client --caps-lock"
          "NONE,Num_Lock,spawn,swayosd-client --num-lock"
          "NONE,XF86Sleep,spawn,${swaylock}; systemctl suspend"
          "NONE,XF86Standby,spawn,${swaylock}; systemctl suspend"
          "SUPER+CTRL,s,spawn,grim -l 0 - | wl-copy"
          "SUPER+SHIFT,e,spawn,wl-paste | swappy -f -"
          "none,Print,spawn,grim -g \"$(slurp -w 0)\" - | wl-copy"
          "SUPER,o,toggleoverview"
          "SUPER+SHIFT,v,spawn,${lib.getExe (pkgs.writeShellScriptBin "fuzzel-clipboard" ''
            set -euo pipefail
            sel=$(${lib.getExe pkgs.cliphist} list | ${fuzzelDmenu "clip> "})
            [ -z "$sel" ] && exit 0
            ${lib.getExe pkgs.cliphist} decode <<< "$sel" | ${lib.getExe pkgs.wl-clipboard} wl-copy
          '')}"

        "SUPER+SHIFT,Escape,spawn,${lib.getExe (pkgs.writeShellScriptBin "power-menu" ''
            set -euo pipefail
            chosen=$(printf "Lock\nLogout\nSuspend\nHibernate\nReboot\nShutdown" | ${fuzzelDmenu "power> "})
            case "$chosen" in
              Lock)      loginctl lock-session ;;
              Logout)    loginctl terminate-user "$USER" ;;
              Suspend)   systemctl suspend ;;
              Hibernate) systemctl hibernate ;;
              Reboot)    systemctl reboot ;;
              Shutdown)  systemctl poweroff ;;
            esac
          '')}"
        ];

        mousebind = [
          "SUPER,btn_left,moveresize,curmove"
          "SUPER,btn_right,moveresize,curresize"
          "NONE,btn_middle,togglemaximizescreen,0"
          # "NONE,btn_left,toggleoverview,-1"
          # "NONE,btn_right,killclient,0"  
        ];

        # From mango.conf: no axisbind existed in the nix config yet
        axisbind = [
          "SUPER,UP,viewtoleft_have_client"
          "SUPER,DOWN,viewtoright_have_client"
        ];

        # From mango.conf: no layerrule existed in the nix config yet
        layerrule = [
          "animation_type_open:zoom,layer_name:fuzzel"
          "animation_type_close:zoom,layer_name:fuzzel"
        ];

        gesturebind = [
          "none,left,3,focusdir,left"
          "none,right,3,focusdir,right"
          "none,up,3,focusdir,up"
          "none,down,3,focusdir,down"
          "none,left,4,viewtoleft_have_client"
          "none,right,4,viewtoright_have_client"
          "none,up,4,toggleoverview"
          "none,down,4,toggleoverview"
        ];

        tagrule = [
          "id:1,layout_name:fair"
          "id:2,layout_name:fair"
          "id:3,layout_name:fair"
          "id:4,layout_name:fair"
          "id:5,layout_name:fair"
          "id:6,layout_name:fair"
          "id:7,layout_name:fair"
          "id:8,layout_name:fair"
          "id:9,layout_name:fair"
        ];

        keymode = {
          resize = {
            bind = [
              "NONE,Left,resizewin,-10,0"
              "NONE,Escape,setkeymode,default"
            ];
          };
        };
      };
    };
  };
in {
  flake.nixosModules.mango = { pkgs, ... }: {
    imports = [ inputs.mangowm.nixosModules.mango ];
    environment.systemPackages = [
     self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty
     self.packages.${pkgs.stdenv.hostPlatform.system}.swaylock
     self.packages.${pkgs.stdenv.hostPlatform.system}.swayidle
     self.packages.${pkgs.stdenv.hostPlatform.system}.fuzzel
     pkgs.swayosd
    ];
    programs.mango = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.mangowc;
    };
    security.pam.services.swaylock = {};
  };

  perSystem = { pkgs, ... }: {
    packages.mangowc = inputs.wrapper-modules.wrappers.mangowc.wrap {
      inherit pkgs;
      imports = [ mangowcModule ];
    };
  };
}
