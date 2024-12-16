{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    dig
    direnv
    fzf
    gh
    gojq
    htop
    hugo
    pass
    pre-commit
    semver
    shellcheck
    tree
    wget
    yq-go
    zoxide
  ];

  programs.zoxide.enable = true;
}
