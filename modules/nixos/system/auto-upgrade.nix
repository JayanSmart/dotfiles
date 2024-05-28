{ config, pkgs, lib, ... }: {

  # This setting only applies to NixOS, different on Darwin
  nix.gc.dates = "09:03"; # Run every morning (but before upgrade)

  # Update the system daily by pointing it at the flake repository
  system.autoUpgrade = {
    enable = config.server; # Only auto upgrade servers
    dates = "09:33";
    flake = "git+${config.dotfilesRepo}";
    randomizedDelaySec = "25min";
    operation = "switch";
    allowReboot = true;
    rebootWindow = {
      lower = "09:01";
      upper = "11:00";
    };
  };
}
