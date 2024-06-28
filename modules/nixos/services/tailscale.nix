{ config, lib, ... }: {

  config = lib.mkIf config.services.tailscale.enable {
    services.tailscale = {
      openFirewall = true;
      authKeyFile = ./tailscale_auth.secret;
      extraUpFlags = [ "--ssh" ];
    };
  };

}
