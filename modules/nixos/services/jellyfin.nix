{ config, lib, ... }: {

  config = lib.mkIf config.services.jellyfin.enable {
    services.jellyfin = { openFirewall = true; };
  };
}
