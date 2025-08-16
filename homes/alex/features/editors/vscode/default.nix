{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
  ];

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        golang.go
        jdinhlife.gruvbox
      ];

      userSettings = {
        "security.workspace.trust.untrustedFiles" = "open";
        "go.toolsManagement.autoUpdate" = true;
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Gruvbox Dark Medium";
          "redhat.telemetry.enabled" = false;
        "explorer.confirmDelete" = false;
        "extensions.ignoreRecommendations" = true;
        "window.density.editorTabHeight" = "compact";
        "window.menuBarVisibility" = "visible";
        "window.titleBarStyle" = "custom";
        "editor.fontSize" = 16;
        "editor.rulers" = [
          120
        ];
        "editor.fontFamily" = "'JetBrains Mono NL', 'Droid Sans Mono', 'monospace', monospace";
      };
    };
  };
}
