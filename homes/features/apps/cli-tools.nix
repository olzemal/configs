{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    dig
    direnv
    fzf
    gh
    gnumake
    jq
    htop
    hugo
    openssl
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
