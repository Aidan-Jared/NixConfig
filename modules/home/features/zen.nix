{ self, inputs, ... }:
{
  flake.homeModules.zen = { pkgs, lib, ... }:
  let
    extension = shortId: guid: {
      name = guid;
      value = {
        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
        installation_mode = "normal_installed";
      };
    };

    # about:config prefs — these are locked so users can't change them.
    # Browse all available prefs at about:config in the browser.
    prefs = {
      "extensions.autoDisableScopes"     = 0;       # don't disable sideloaded extensions
      "extensions.pocket.enabled"        = false;
      "browser.tabs.warnOnClose"         = false;
      "browser.startup.page"             = 3;        # restore previous session
      "browser.newtabpage.enabled"       = false;    # blank new tab
      "browser.search.suggest.enabled"   = true;
      "privacy.donottrackheader.enabled" = true;
      "media.ffmpeg.vaapi.enabled"       = true;     # hardware video decode
      "gfx.webrender.all"                = true;     # WebRender compositor
    };

    # Extensions to auto-install from AMO.
    # Find more at https://addons.mozilla.org — grab the slug from the URL,
    # then the GUID from https://addons.mozilla.org/api/v5/addons/addon/<slug>/
    extensions = [
      (extension "ublock-origin"          "uBlock0@raymondhill.net")
      # Ghostery — tracker & ad blocker
      (extension "ghostery"                        "firefox@ghostery.com")
      # Hide Google AI Overviews
      (extension "hide-google-ai-overviews"        "{a6ffd177-abc4-4f1c-8e83-3db4acb01b17}")
      # OneTab — save tabs to a list
      (extension "onetab"                          "extension@one-tab.com")
      # Harper — private offline grammar checker
      (extension "private-grammar-checker-harper"  "harper@writewithharper.com")
      # SponsorBlock — skip YouTube sponsor segments
      (extension "sponsorblock"                    "sponsorBlocker@ajay.app")
    ];   
  in{
    home.packages = [
      (pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        {
          # Lock prefs via autoconfig
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
            ) prefs
          );

          extraPolicies = {
            DisableTelemetry          = true;
            DisableAppUpdate          = true;  # Nix manages updates
            DisableFirefoxAccounts    = false; # set true to block Firefox Sync
            DisableFormHistory        = false;
            PasswordManagerEnabled    = true;

            # Auto-install extensions
            ExtensionSettings = builtins.listToAttrs extensions;

            # Search engine configuration
            SearchEngines = {
              Default = "ddg";               # DuckDuckGo
              PreventInstalls = false;
              Add = [
                {
                  Name        = "Kagi";
                  URLTemplate = "https://kagi.com/search?q={searchTerms}";
                  Alias       = "@k";
                }
                {
                  Name        = "nixpkgs";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL     = "https://wiki.nixos.org/favicon.ico";
                  Alias       = "@np";
                }
                {
                  Name        = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL     = "https://wiki.nixos.org/favicon.ico";
                  Alias       = "@no";
                }
                {
                  Name        = "WolframAlpha";
                  URLTemplate = "https://www.wolframalpha.com/input?i={searchTerms}";
                  IconURL     = "https://www.wolframalpha.com/favicon.ico";
                  Alias       = "@w";
                }
              ];
            };

            # Permissions — pre-grant or block per origin
            Permissions = {
              Camera      = { BlockNewRequests = false; };
              Microphone  = { BlockNewRequests = false; };
              Notifications = { BlockNewRequests = true; }; # block notification spam
              Autoplay    = {
                Default = "block-audio";  # block audio autoplay, allow video
              };
            };
          };
        }
      )
    ];
    
  };
}

