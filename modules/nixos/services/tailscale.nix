{ config, pkgs, lib, ... }: {

  config = lib.mkIf config.services.tailscale.enable {
    services.tailscale = {
      openFirewall = true;
      authKeyFile = config.tailscale_auth_file;
      extraUpFlags = [ ];
    };
  };

}
