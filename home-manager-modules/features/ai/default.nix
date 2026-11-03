{ lib, pkgs, config, ... }:

{
  options.features.ai = {
    opencode.enable = lib.mkEnableOption "opencode";
    codex.enable = lib.mkEnableOption "codex";
  };

  config = {
    home.packages = with pkgs; []
    ++ lib.optionals config.features.ai.opencode.enable [ opencode ];

    programs.codex = {
      enable = config.features.ai.codex.enable;
    };
  };
}
