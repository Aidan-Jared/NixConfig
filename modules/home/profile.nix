
{ self, inputs, ... }: {

  flake.homeModules.profile = { pkgs, ... }: {
    profile = {
      editor = "hx";
      terminal = "ghostty";
      font = "Fira Code";
      darkMode = true;
      browser = "zen";
    };
  };
}
