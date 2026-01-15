{ pkgs, ... }:

{
  home.packages = with pkgs.edge; [
    opencode
  ];
}
