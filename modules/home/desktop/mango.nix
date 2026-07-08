{ inputs, self, pkgs, lib, ... }: {

  flake.nixosModules.mango = { pkgs, ... }: {
    programs.mango = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.mango;
    };
  };

  flake.wrappersModules.mango = let
        noctaliaExe = lib.getExe inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      in { config, lib, pkgs, ... }: {
    
    autostart_sh = ''
     noctaliaExe 
     (lib.getExe (
         pkgs.writeShellScriptBin "wallpaper"
         "${lib.getExe pkgs.swaybg} -i ${self.wallpaper} -m fill"
       ))
    '';

    options.terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
    };


    settings = {
      # Window effects
      blur = 1;
      blur_optimized = 1;
      blur_params = {
        radius = 5;
        num_passes = 2;
      };
      border_radius = 6;
      focused_opacity = 0.9;
      unfocused_opacity = 0.6;

      # Animations - use underscores for multi-part keys
      animations = 1;
      animation_type_open = "fade";
      animation_type_close = "fade";
      animation_duration_open = 400;
      animation_duration_close = 800;
      gappih=0;
      gappiv=0;
      gappoh=0;
      gappov=0;
      borderpx=1;
      no_border_when_single=1;
      # fun colors are not suckless
      focuscolor="0x005577ff";
      # Or use nested attrs (will be flattened with underscores)
      animation_curve = {
        open = "0.46,1.0,0.29,1";
        close = "0.08,0.92,0,1";
      };

      new_is_master=0;
      enable_hotarea=0;
      warpcursor=1;
      sloppyfocus=1;
      axis_bind_apply_timeout=100;
      drag_tile_to_tile=1;
      enable_floating_snap=0;
      snap_distance=30;
      # Use lists for duplicate keys like bind and tagrule
      bind = [
        "SUPER,t,spawn,${config.terminal}"

        "SUPER,space,spawn,${inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/vicinae toggle"

        "Mod+Escape,${noctaliaExe},msg,session,lock"

        "SUPER,1,comboview,1"
        "SUPER,2,comboview,2"
        "SUPER,3,comboview,3"
        "SUPER,4,comboview,4"
        "SUPER,5,comboview,5"
        "SUPER,6,comboview,6"
        "SUPER,7,comboview,7"
        "SUPER,8,comboview,8"
        "SUPER,9,comboview,9"

        # switch window focus
        "SUPER,j,focusstack,next"
        "SUPER,k,focusstack,prev"

        # DWM style binds
        "SUPER,i,incnmaster,+1"
        "SUPER,d,incnmaster,-1"
        "SUPER,h,setmfact,-0.05"
        "SUPER,l,setmfact,+0.05"
        "SUPER,Return,zoom"
        "SUPER,code:60,focusmon,right"
        "SUPER+shift,code:60,tagmon,right,0"
        "SUPER,q,killclient"

        # Unfortunately stack based exchange is still being worked on.
        # take these lesser directional based ones. 
        "SUPER+SHIFT,f,togglefullscreen,"
        "SUPER,f,togglefloating,"

        # smartmovewin
        "CTRL+SHIFT,k,smartmovewin,up"
        "CTRL+SHIFT,j,smartmovewin,down"
        "CTRL+SHIFT,h,smartmovewin,left"
        "CTRL+SHIFT,l,smartmovewin,right"

        # switch window focus
        "SUPER,j,focusstack,next"
        "SUPER,k,focusstack,prev"
        "SUPER,h,focusdir,left"
        "SUPER,l,focusdir,right"

        # swap window
        "SUPER+SHIFT,k,exchange_client,up"
        "SUPER+SHIFT,j,exchange_client,down"
        "SUPER+SHIFT,h,exchange_client,left"
        "SUPER+SHIFT,l,exchange_client,right"

        # scratcpad
        "SUPER,i,minimized"
        "SUPER+SHIFT,i,restore_minimized"
        "SUPER,z,toggle_scratchpad"

        # Layouts
        "SUPER,t,setlayout,tile"
        "SUPER,v,setlayout,vertical_grid"
        "SUPER,c,setlayout,spiral"
        "SUPER,n,setlayout,switch_layout"
        "SUPER,m,setlayout,monocle"
        "SUPER,s,setlayout,scroller"
        "SUPER+SHIFT,s,setlayout,vertical_scroller"

        #file managers
        "SUPER+CTRL,e,spawn,pcmanfm"
        "SUPER,e,spawn,ghostty -e yazi"

        # Media keys
        "none,XF86AudioRaiseVolume,spawn,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        "none,XF86AudioLowerVolume,spawn,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        "none,XF86AudioMute,spawn,wpctl set-mute -l 1.4 @DEFAULT_AUDIO_SINK@ toggle"
        "none,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "none,XF86MonBrightnessUp,spawn,brightnessctl set 5%+"
        "none,XF86MonBrightnessDown,spawn,brightnessctl set 5%-"
        "none,XF86Sleep,${noctaliaExe},msg,session,lock-and-suspend"
        "none,XF86Standby,${noctaliaExe},msg,session,lock-and-suspend"


        # Screenshots
        "SUPER+CTRL,s,spawn,grim -l 0 - | wl-copy"
        "SUPER+SHIFT,e,spawn,wl-paste | swappy -f -"
        "none,Print,spawn,grim -g \"$(slurp -w 0)\" - | wl-copy""SUPER,o,toggleoverview"
      ];

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
        "NONE,btn_left,toggleoverview,-1"
        "NONE,btn_right,killclient,0"  
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
        "id:1,layout_name:tile"
        "id:2,layout_name:tile"
        "id:3,layout_name:tile"
        "id:4,layout_name:tile"
        "id:5,layout_name:tile"
        "id:6,layout_name:tile"
        "id:7,layout_name:tile"
        "id:8,layout_name:tile"
        "id:9,layout_name:tile"

        # more layouts:
        # vertical:vertical_tile,vertical_scroller,vertical_grid,vertical_monocle,vertical_spiral,vertical_dwindle
        # Plus more being added
      ];

      # Keymodes (submaps) for modal keybindings
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

  perSystem = { lib, pkgs, ... }: {
    packages.mangowc = inputs.wrapper-modules.wrappers.mangowc.wrap {
      inherit pkgs;
      package = lib.mkForce self.mangowm.nixosModules.mango;
      imports = [
        self.wrappersModules.mango 
      ];
    };
  };
}
