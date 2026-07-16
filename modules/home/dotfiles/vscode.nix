
{ self, inputs, ... }: {
  flake.homeModules.vscode = { pkgs, lib, ... }: {

    home.packages = [
      pkgs.vscode
    ];
    
    programs.vscode = {
      enable = true;
      argvSettings = ''
      {
          "chat.agent.enabled": false,
          "chat.agent.thinking.generateTitles": false,
          "workbench.secondarySideBar.defaultVisibility": "hidden",
          "chat.agent.thinking.terminalTools": false,
          "chat.checkpoints.enabled": false,
          "chat.detectParticipant.enabled": false,
          "chat.disableAIFeatures": true,
          "git.autofetch": true,
          "gitlens.advanced.messages": {
              "suppressLineUncommittedWarning": true
          },
          "r.rterm.linux": "/home/ava/anaconda3/bin/radian",
          "r.alwaysUseActiveTerminal": true,
          "r.bracketedPaste": true,
          "r.plot.useHttpgd": true,
          "r.rpath.linux": "/usr/bin/R",
          "editor.defaultFormatter": "charliermarsh.ruff",
          "editor.formatOnSave": true,
          "editor.codeActionsOnSave": {
            "source.fixAll.ruff": "explicit",
            "source.organizeImports.ruff": "explicit" 
          },
          "[r]":{
              "editor.defaultFormatter": "REditorSupport.r",
              "editor.formatOnSave": true
          },
          "rust-analyzer.check.command": "clippy",
          "editor.wordWrap": "on",
          "harper.dialect": "American",
          "workbench.colorTheme": "Catppuccin Mocha",
          "editor.fontFamily": "Fira Code",
          "editor.fontLigatures": true
      }
      '';
    };
  };
}
