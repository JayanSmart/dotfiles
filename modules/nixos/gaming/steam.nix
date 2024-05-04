{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.gaming.steam.enable = lib.mkEnableOption "Steam game launcher.";

  config = lib.mkIf (config.gaming.steam.enable && pkgs.stdenv.isLinux) {

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      #  extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    #environment.systemPackages = with pkgs; [
    #    steamPackages.steamcmd
    #    stream-tui
    #];
    networking.networkmanager.enable = true; # Apparently improved performance
  };
}
