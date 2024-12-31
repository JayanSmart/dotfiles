{ config, lib, ... }: {

  config = lib.mkIf config.services.plex.enable {
    unfreePackages = [ "plexmediaserver" ];
    services.plex = {
      openFirewall = true;
      user = "jayan";
    };
  };
}
