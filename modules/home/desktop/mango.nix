{ inputs, self, ... }: 
let
  mangowcModule = { config, lib, pkgs, ... }: let
    swaylock = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.swaylock;
    vicinaeExe = lib.getExe inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;
    wallpaper = if pkgs.lib.hasSuffix ".mp4" (toString self.wallpaper) then
    pkgs.runCommand "converted-wallpaper.gif" { nativeBuildInputs = [ pkgs.ffmpeg ]; } ''
      ${pkgs.ffmpeg}/bin/ffmpeg -i ${self.wallpaper} \
        -vf "fps=24,scale=1920:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
        $out
    ''
  else
    self.wallpaper;
      # swayosd = lib.getExe ;
  in {
    options.terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
    };

    config = {
      package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
      
        # waybar &
        # ${noctaliaExe} &
      autostart_sh = ''
        waybar &
        awww-daemon &
        
        ${(lib.getExe (
           pkgs.writeShellScriptBin "wallpaper"
           "${lib.getExe pkgs.awww} img ${wallpaper}"
         ))} &
        wl-paste --watch ${lib.getExe pkgs.cliphist} store &
        vicinae server &
      '';

      settings = {
       	blur = 1;
       	blur_layer = 1;
       	blur_optimized=1;
       	blur_params = {
      		num_passes = 2;
      		radius = 5;
      		noise = 0.02;
      		brightness = 0.9;
      		contrast = 0.9;
      		saturation = 1.2;
     	};

     	shadows = 0;
     	layer_shadows = 0;
     	shadow_only_floating = 1;
     	shadows_size = 10;
     	shadows_blur = 15;
     	shadows_position_x = 0;
     	shadows_position_y = 0;
     	shadowscolor= "0x000000ff";

     	border_radius=6;
     	no_radius_when_single = 1;
     	focused_opacity = 0.90;
     	unfocused_opacity = 0.70;

     	# Animation Configuration(support type:zoom,slide);
     	# tag_animation_direction: 1-horizontal,0-vertical;
     	animations=1;
     	layer_animations=1;
     	animation_type_open="slide";
     	animation_type_close="slide";
     	animation_fade_in=1;
     	animation_fade_out=1;
     	tag_animation_direction=0;
     	zoom_initial_ratio=0.4;
     	zoom_end_ratio=0.8;
     	fadein_begin_opacity=0.5;
     	fadeout_begin_opacity=0.8;
     	animation_duration_move=500;
     	animation_duration_open=400;
     	animation_duration_tag=350;
     	animation_duration_close=800;
     	animation_duration_focus=0;
     	animation_curve = {
      		open="0.46,1.0,0.29,1";
      		move="0.46,1.0,0.29,1";
      		tag="0.46,1.0,0.29,1";
      		close="0.08,0.92,0,1";
      		focus="0.46,1.0,0.29,1";
      		opafadeout="0.5,0.5,0.5,0.5";
      		opafadein="0.46,1.0,0.29,1";
     	};

     	# Scroller Layout Setting;
       	scroller_structs=20;
       	scroller_default_proportion=0.8;
       	scroller_focus_center = 1;
       	scroller_prefer_center = 1;
       	edge_scroller_pointer_focus=1;
       	edge_scroller_focus_allow_speed=0.0;
       	scroller_default_proportion_single=1.0;
       	scroller_proportion_preset="0.5,0.8,1.0";

     	# Master-Stack Layout Setting;
       	new_is_master=1;
       	default_mfact=0.55;
       	default_nmaster=1;
       	smartgaps=0;

       	# Dwindle Layout Setting;
       	dwindle_smart_split=0;
       	dwindle_drop_simple_split=1;
       	dwindle_manual_split=0;
       	dwindle_hsplit=1;
       	dwindle_vsplit = 1;
       	dwindle_preserve_split=0;

       	# Overview Setting;
       	hotarea_size=10;
       	enable_hotarea=0;
       	ov_tab_mode=1;
       	ov_no_resize=1;
       	overviewgappi=5;
       	overviewgappo=30;

     	# Misc;
       	no_border_when_single = 1;
       	axis_bind_apply_timeout=100;
       	focus_on_activate=1;
       	idleinhibit_ignore_visible=0;
       	sloppyfocus=1;
       	warpcursor=1;
       	focus_cross_monitor=0;
       	focus_cross_tag=0;
       	enable_floating_snap=0;
       	snap_distance=30;
       	cursor_size=24;
       	drag_tile_to_tile=1;
       	drag_tile_small=1;

     	# keyboard;
       	repeat_rate=25;
       	repeat_delay=600;
       	numlockon=0;
       	xkb_rules_layout="us";

     	# Trackpad;
     	# need relogin to make it apply;
       	disable_trackpad=0;
       	tap_to_click=1;
       	tap_and_drag=1;
       	drag_lock=1;
       	trackpad_natural_scrolling=0;
       	disable_while_typing=1;
       	left_handed=0;
       	middle_button_emulation=0;
       	swipe_min_threshold=1;

     	# mouse;
     	# need relogin to make it apply;
       	mouse_natural_scrolling=0;

     	# Appearance;
       	gappih = 0;
       	gappiv = 0;
       	gappoh = 0;
       	gappov = 0;
       	scratchpad_width_ratio=0.8;
       	scratchpad_height_ratio=0.9;
       	borderpx=4;
       	rootcolor="0x201b14ff";
       	bordercolor="0x444444ff";
       	dropcolor="0x8FBA7C55";
       	splitcolor="0xEB441EFF";
       	focuscolor="0xc9b890ff";
       	maximizescreencolor="0x89aa61ff";
       	urgentcolor="0xad401fff";
       	scratchpadcolor="0x516c93ff";
       	globalcolor="0xb153a7ff";
       	overlaycolor="0x14a57cff";


     	# layout support:;
     	# tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller;
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

     	# Key Bindings;
     	# key name refer to `xev` or `wev` command output,;
     	# mod keys name: super,ctrl,alt,shift,none;

     	# reload config;
       	bind = [
      		"SUPER,r,reload_config"
      		"SUPER,esc,${swaylock}"

      		# menu and terminal
      		"SUPER,space,spawn,${vicinaeExe}"
          "SUPER+ctrl,v,spawn,"
          "SUPER+SHIFT,Escape,spawn,"
          "Alt,Return,spawn,ghostty"

      		# exit
      		"SUPER,m,quit"
      		"ALT,q,killclient,"

      		# switch window focus
      		"SUPER,Tab,focusstack,next"
      		"ALT,Left,focusdir,left"
      		"ALT,Right,focusdir,right"
      		"ALT,Up,focusdir,up"
      		"ALT,Down,focusdir,down"
      		"ALT,h,focusdir,left"
      		"ALT,l,focusdir,right"
      		"ALT,k,focusdir,up"
      		"ALT,j,focusdir,down"

      		# swap window
      		"SUPER+SHIFT,Up,exchange_client,up"
      		"SUPER+SHIFT,Down,exchange_client,down"
      		"SUPER+SHIFT,Left,exchange_client,left"
      		"SUPER+SHIFT,Right,exchange_client,right"
      		"SUPER+SHIFT,k,exchange_client,up"
      		"SUPER+SHIFT,j,exchange_client,down"
      		"SUPER+SHIFT,h,exchange_client,left"
      		"SUPER+SHIFT,l,exchange_client,right"

      		# switch window status
      		"SUPER,g,toggleglobal,"
      		"ALT,Tab,toggleoverview,"
      		"ALT,backslash,togglefloating,"
      		"ALT,a,togglemaximizescreen,"
      		"ALT,f,togglefullscreen,"
      		"ALT+SHIFT,f,togglefakefullscreen,"
      		"SUPER,i,minimized,"
      		"SUPER,o,toggleoverlay,"
      		"SUPER+SHIFT,I,restore_minimized"
      		"ALT,z,toggle_scratchpad"

      		# scroller layout
      		"ALT,e,set_proportion,1.0"
      		"ALT,x,switch_proportion_preset,"
      		"alt+super+ctrl,Left,scroller_stack,left"
      		"alt+super+ctrl,Right,scroller_stack,right"
      		"alt+super+ctrl,Up,scroller_stack,up"
      		"alt+super+ctrl,Down,scroller_stack,down"
      		"alt+super+ctrl,h,scroller_stack,left"
      		"alt+super+ctrl,l,scroller_stack,right"
      		"alt+super+ctrl,k,scroller_stack,up"
      		"alt+super+ctrl,j,scroller_stack,down"

      		#dwindle layout(manual split mode)
      		"alt+shift,Return,dwindle_toggle_split_direction"

      		# switch layout
      		"SUPER,n,switch_layout"

      		# tag switch
      		"SUPER,Left,viewtoleft,0"
      		"CTRL,Left,viewtoleft_have_client,0"
      		"SUPER,Right,viewtoright,0"
      		"CTRL,Right,viewtoright_have_client,0"
      		"CTRL+SUPER,Left,tagtoleft,0"
      		"CTRL+SUPER,Right,tagtoright,0"
      		"SUPER,h,viewtoleft,0"
      		"CTRL,h,viewtoleft_have_client,0"
      		"SUPER,l,viewtoright,0"
      		"CTRL,l,viewtoright_have_client,0"
      		"CTRL+SUPER,h,tagtoleft,0"
      		"CTRL+SUPER,l,tagtoright,0"

      		"SUPER,1,view,1,0"
      		"SUPER,2,view,2,0"
      		"SUPER,3,view,3,0"
      		"SUPER,4,view,4,0"
      		"SUPER,5,view,5,0"
      		"SUPER,6,view,6,0"
      		"SUPER,7,view,7,0"
      		"SUPER,8,view,8,0"
      		"SUPER,9,view,9,0"

      		# tag: move client to the tag and focus it
      		# tagsilent: move client to the tag and not focus it
      		"# Alt,1,tagsilent,1"
      		"Alt,1,tag,1,0"
      		"Alt,2,tag,2,0"
      		"Alt,3,tag,3,0"
      		"Alt,4,tag,4,0"
      		"Alt,5,tag,5,0"
      		"Alt,6,tag,6,0"
      		"Alt,7,tag,7,0"
      		"Alt,8,tag,8,0"
      		"Alt,9,tag,9,0"

      		# monitor switch
      		"alt+shift,Left,focusmon,left"
      		"alt+shift,Right,focusmon,right"
      		"SUPER+Alt,Left,tagmon,left"
      		"SUPER+Alt,Right,tagmon,right"
      		"alt+shift,h,focusmon,left"
      		"alt+shift,l,focusmon,right"
      		"SUPER+Alt,h,tagmon,left"
      		"SUPER+Alt,l,tagmon,right"

      		# gaps
      		"ALT+SHIFT,X,incgaps,1"
      		"ALT+SHIFT,Z,incgaps,-1"
      		"ALT+SHIFT,R,togglegaps"

      		# movewin
      		"CTRL+SHIFT,Up,movewin,+0,-50"
      		"CTRL+SHIFT,Down,movewin,+0,+50"
      		"CTRL+SHIFT,Left,movewin,-50,+0"
      		"CTRL+SHIFT,Right,movewin,+50,+0"
      		"CTRL+SHIFT,k,movewin,+0,-50"
      		"CTRL+SHIFT,j,movewin,+0,+50"
      		"CTRL+SHIFT,h,movewin,-50,+0"
      		"CTRL+SHIFT,l,movewin,+50,+0"

      		# resizewin
      		"CTRL+ALT,Up,resizewin,+0,-50"
      		"CTRL+ALT,Down,resizewin,+0,+50"
      		"CTRL+ALT,Left,resizewin,-50,+0"
      		"CTRL+ALT,Right,resizewin,+50,+0"
      		"CTRL+ALT,k,resizewin,+0,-50"
      		"CTRL+ALT,j,resizewin,+0,+50"
      		"CTRL+ALT,h,resizewin,-50,+0"
      		"CTRL+ALT,l,resizewin,+50,+0"

      		# comboview
      		"SUPER,1,comboview,1"
      		"SUPER,2,comboview,2"
      		"SUPER,3,comboview,3"
      		"SUPER,4,comboview,4"
      		"SUPER,5,comboview,5"
      		"SUPER,6,comboview,6"
      		"SUPER,7,comboview,7"
      		"SUPER,8,comboview,8"
      		"SUPER,9,comboview,9"

      		# Axis Bindings
      		"axisSUPER,UP,viewtoleft_have_client"
      		"axisSUPER,DOWN,viewtoright_have_client"
      		"axisSUPER,k,viewtoleft_have_client"
      		"axisSUPER,j,viewtoright_have_client"

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
          "SUPER+CTRL,s,spawn,${lib.getExe config.pkgs.grim} -l 0 - | ${config.pkgs.wl-clipboard}/bin/wl-copy"
          "SUPER+SHIFT,e,spawn,${config.pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe config.pkgs.swappy} -f -"
          "none,Print,spawn,${lib.getExe (config.pkgs.writeShellApplication {
            name = "screenshot";
            text = ''
              ${lib.getExe config.pkgs.grim} -g "$(${lib.getExe config.pkgs.slurp} -w 0)" - \
              | ${config.pkgs.wl-clipboard}/bin/wl-copy
            '';})}"
       	];

       	mousebind = [
      		# Mouse Button Bindings;
      		# btn_left and btn_right can't bind none mod key;
      		"SUPER,btn_left,moveresize,curmove"
      		"NONE,btn_middle,togglemaximizescreen,0"
      		"SUPER,btn_right,moveresize,curresize"
       	];

       	# layerrule = [
      		# "animation_type_open:zoom,layer_name:fuzzel"
      		# "animation_type_close:zoom,layer_name:fuzzel"
       	# ];

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
     pkgs.cliphist
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
