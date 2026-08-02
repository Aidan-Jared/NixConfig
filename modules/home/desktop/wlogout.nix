
{self, inputs, ...}:
{
  flake.homeModules.wlogout = {pkgs, lib, ...}: {
    programs.wlogout = {
      enable = true;
      layout = [
       	{
   	     label = "lock";
   	     action = "swaylock";
   	     text ="LOCK";
   	     keybind = "l";
       	}
       	{
   	     label = "logout";
   	     action = "loginctl terminate-user \"$USER\"";
   	     text ="LOGOUT";
   	   	 keybind = "e";
       	}
       	{
   	     label = "suspend";
   	     action = "loginctl suspend";
   	     text ="SUSPEND";
   	   	 keybind = "s";
       	}
       	{
   	     label = "hibernate";
   	     action = "loginctl hibernate";
   	     text ="HIBERNATE";
   	   	 keybind = "h";
       	}
       	{
   	     label = "shutdown";
   	     action = "loginctl poweroff";
   	     text ="SHUTDOWN";
   	   	 keybind = "u";
       	}
       	{
   	     label = "reboot";
   	     action = "loginctl reboot";
   	     text ="REBOOT";
   	   	 keybind = "r";
       	}
      ];

      style = ''
        @define-color void   #0a0a0c;
        @define-color stone  #38383c;
        @define-color bone   #d4d0c4;
        @define-color sigil  #6a5a78;
        @define-color color13 @sigil;

        * {
       	background-image: none;
       	box-shadow: none;
        }

        window {
       	background-color: rgba(10, 10, 12, 0.92);
        }

        button {
            background-repeat: no-repeat;
            background-position: center;
            background-size: 15%;
            background-color: rgba(212, 208, 196, 0.08);
            margin:5px;
            transition: all 0.3s cubic-bezier(.55, 0.0, .28, 1.682), box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
            border-radius: 4px;
            border: 1px solid @stone;
            outline-style: none;
        }

        button:hover {
       	background-color: rgba(106, 90, 120, 0.15);
            color: @color13;
            background-size: 25%;
            margin: 15px;
            border-radius: 4px;
            border-color: @sigil;
            outline-style: none;
            box-shadow: 0 8px 32px 0 rgba(106, 90, 120, 0.25);
        }

        #lock {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
        }

        #logout {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
        }

        #suspend {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
        }

        #hibernate {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
        }

        #shutdown {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
        }

        #reboot {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
        }
      '';
    };
  };
}
