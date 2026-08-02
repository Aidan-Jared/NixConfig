
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
   	     action = "hyprctl dispatch exit";
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
        * {
       	background-image: none;
       	box-shadow: none;
        }

        window {
       	background-color: rgba(12, 12, 12, 0.9);
        }

        button {
            background-repeat: no-repeat;
            background-position: center;
            background-size: 15%;
            background-color: rgba(255, 255, 255, 0.2);
            margin:5px;
            animation: gradient_f 10s ease-in infinite;
            transition: all 0.3s cubic-bezier(.55, 0.0, .28, 1.682), box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
            border-radius: 80px;
            border:30px;
            outline-style: none;
        }

        button:hover {
       	background-color: transparent; 
            color: @color13;
            background-size: 25%;
            margin: 15px;
            border-radius: 80px;
            outline-style: none;
            box-shadow: 0 8px 32px 0 rgba(255, 255, 255, 0.3);
        }

        #lock {
            background-image: image(url("/usr/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
        }

        #logout {
            background-image: image(url("/usr/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
        }

        #suspend {
            background-image: image(url("/usr/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
        }

        #hibernate {
            background-image: image(url("/usr/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
        }

        #shutdown {
            background-image: image(url("/usr/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
        }

        #reboot {
            background-image: image(url("/usr/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
        }
      '';
    };
  };
}
