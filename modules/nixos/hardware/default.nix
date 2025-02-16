{ lib, ... }:
{
  imports = [
    ./openrgb.nix
    # ./graphics.nix
  ];

  options = {
    physical = lib.mkEnableOption "Whether this machine is a physical device.";
    server = lib.mkEnableOption "Whether this machine is a server.";
  };
}
