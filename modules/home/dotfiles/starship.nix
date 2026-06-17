{ self, inputs, ... }: {
  flake.homeModules.starship = { ... }: {
    programs.starship = {
      enable = true;
      settings = {# Get editor completions based on the config schema
        add_newline = true;

        character = {
         	disabled = false;
         	success_symbol = "[=>](#e040c0)";
         	error_symbol = "[=>](red)";
         	vimcmd_symbol = "[<-](#30e890)";
        };

        username = {
         	style_user = "#89b4fa";
         	show_always = true;
         	format = "\[[$user]($style)\]";
        };
        
        # Disable the package module, hiding it from the prompt completely
        package = {
         	format = "\[[$symbol$version]($style)\]";
         	disabled = true;
         	symbol = "󰏗 ";
         	style = "orange";
        };

        aws = {
         	symbol = " ";
         	format = "\[[$symbol($profile)(\($region\))(\[$duration\])]($style)\]";
         	style = "bright-black";
        };

        azure = {
         	symbol = " ";
         	format = "\[[$symbol($subscription)]($style)\]";
        };

        battery = {
         	format = "\[[$symbol$percentage]($style)\]";
        };

        buf = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
        };

        bun = {
         	symbol = " ";
         	style = "bg:green";
         	format = "\[[$symbol($version)]($style)\]";
        };
        
        c = {
          symbol = " ";
          style = "bright-black";
         	format = "\[[$symbol($version(-$name))]($style)\]";
        };

        cpp = {
         	symbol = " ";
         	format = "\[[$symbol \[$name\]]($style)\]";
         	style = "bright-black";
        };

        cmake = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
         	style = "bright-black";
        };

        conda = {
         	symbol = " ";
         	format = "\[[$symbol$environment]($style)\]";
         	ignore_base = false;
         	style = "#30e890";
        };

        container = {
         	format = "\[[$symbol$environment]($style)\]";
         	symbol = " ";
         	style = "bright-black";
        };

        direnv = {
         	symbol = " ";
         	format = "\[[$symbol$loaded/$allowed]($style)\]";
         	style = "bright-black";
        };
        
        docker_context = {
         	symbol = " ";
         	format = "\[[$symbol$context]($style)\]";
         	style = "bright-black";
        };

        git_branch = {
          symbol = " ";
          format = "\[[$symbol$context $branch]($style)\]";
          truncation_length = 10;
          truncation_symbol = "";
          style = "#c080f8";
          # ignore_branches = ["master", "main"]
        };
  
        git_commit = {
         	commit_hash_length = 4;
         	tag_symbol = "  ";
         	format = "\[[\($hash$tag\)]($style)\]";
         	style = "#4a5068";
        };

        git_state = {
         	format = "\[[$state ($progress_current/$progress_total)]($style)\]";
        };

        git_metrics = {
          added_style = "bold blue";
         	format = "\[[+$added]($added_style)\]\[[-$deleted]($deleted_style)\]";
        };

        git_status = {
          format = "([\[$all_status\] \[$ahead_behind\];]($style))";
          stashed = "[📦](orange)";
          staged = "[++\($count\)](green)";
          up_to_date = "[✓](#30e890)";
          modified = "[changed(#40e8ff)";
          conflicted = "[conflicted(red)";
          untracked = "[untracked(#4a5068)";
         	# deleted = "🗑";
         	ahead = "⇡$(count)";
         	diverged = "⇕⇡$(ahead_count)⇣$(behind_count)";
         	behind = "⇣$(count)";
       	};


        golang = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
       	};

        haskell = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
       	};

        hostname = {
         	ssh_symbol = " ";
         	format = "\[[$ssh_symbol($hostname)]($style)\] ";
       	};

        java = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
       	};

        kotlin = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
       	};

        kubernetes = {
         	symbol = "󱃾 ";
         	format = "\[[$symbol$context( \($namespace\))]($style)\]";
       	};

        lua = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
       	};

        memory_usage = {
         	symbol = "󰍛 ";
         	format = "\[$symbol[$ram( | $swap)]($style)\]";
       	};

        nim = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
       	};

        nix_shell = {
         	symbol = " ";
         	disabled = false;
         	format = "\[[$symbol$state( \($name\))]($style)\]";
         	impure_msg = "impure";
         	pure_msg = "pure";
         	unknown_msg = "unknown";
       	};

        nodejs = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
       	};

        os = {
         	format = "\[[$symbol]($style)\]";
         	symbols = {
           	AIX = " ";
           	AlmaLinux = " ";
           	Alpaquita = " ";
           	Alpine = " ";
           	ALTLinux = " ";
           	Amazon = " ";
           	Android = " ";
           	AOSC = " ";
           	Arch = " ";
           	Artix = " ";
           	Bluefin = " ";
           	CachyOS = " ";
           	CentOS = " ";
           	Debian = " ";
           	DragonFly = " ";
           	Elementary = " ";
           	Emscripten = " ";
           	EndeavourOS = " ";
           	Fedora = " ";
           	FreeBSD = " ";
           	Garuda = " ";
           	Gentoo = " ";
           	HardenedBSD = "󰞌 ";
           	Illumos = " ";
           	InstantOS = " ";
           	Ios = "󰀷 ";
           	Kali = " ";
           	Linux = " ";
           	Mabox = " ";
           	Macos = " ";
           	Manjaro = " ";
           	Mariner = " ";
           	MidnightBSD = " ";
           	Mint = " ";
           	NetBSD = " ";
           	NixOS = " ";
           	Nobara = " ";
           	OpenBSD = " ";
           	OpenCloudOS = " ";
           	openEuler = " ";
           	openSUSE = " ";
           	OracleLinux = "󰺡 ";
           	PikaOS = " ";
           	Pop = " ";
           	Raspbian = " ";
           	Redhat = "󱄛 ";
           	RedHatEnterprise = "󱄛 ";
           	Redox = "󰀘 ";
           	RockyLinux = " ";
           	Solus = " ";
           	SUSE = " ";
           	Ubuntu = " ";
           	Ultramarine = " ";
           	Unknown = " ";
           	Uos = " ";
           	Void = " ";
           	Windows = "󰍲 ";
           	Zorin = " ";
         	};
       	};

        python = {
         	symbol = " ";
         	format = "\[[$(symbol)$(pyenv_prefix)($(version))(\($virtualenv\))]($style)\]";
         	pyenv_version_name = true;
         	python_binary = [[ "uv" "run" "--no-python-downloads" "--no-project" "python" ]];
         	style = "#40e8ff";
        };

        quarto = {
         	format = "\[[$symbol($version)]($style)\]";
        };

        rlang = {
         	symbol = "󰟔 ";
         	format = "\[[$symbol($version)]($style)\]";
        };

        rust = {
         	symbol = "󱘗 ";
         	format = "\[[$symbol($version)]($style)\]";
         	style = "#ff8030";
        };

        shell = {
          fish_indicator = "󰈺 ";
          powershell_indicator = "_";
          unknown_indicator = "mystery shell";
          format = "\[[$indicator]($style)\]";
          disabled = false;
        };

        status = {
          symbol = " ";
          success_symbol = "";
          format = "\[[$symbol$status]($style)\]";
          map_symbol = true;
          disabled = true;
        };

        sudo = {
          format = "\[[as $symbol]($style)\]";
          symbol = " ";
          disabled = false;
        };
  
        typst = {
         	symbol = " ";
         	format = "\[[$symbol($version)]($style)\]";
        };

        zig = {
         	format = "\[[$symbol($version)]($style)\]";
         	symbol = " ";
        };

        directory = {
         	format = "\[[ $path ]($style)[$read_only]($read_only_style)\]";
         	style = "#d0c8e8";
         	# truncation_length = 1000;
         	# truncation_symbol = "…/";
         	# truncate_to_repo = true;
         	read_only = " 󰌾";
        };


        cmd_duration = {
         	min_time = 2000;
         	show_milliseconds = true;
         	show_notifications = false;
         	min_time_to_notify = 45000;
         	format = "\[[$time]($style)\]";
         	disabled = false;
         	style = "#4a5068";
        };

        line_break.disabled = false;
      };
    };
  };
}
