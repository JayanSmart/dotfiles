{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [ ./steam.nix ];

  options.gaming.enable = lib.mkEnableOption "Enable gaming features.";
}
