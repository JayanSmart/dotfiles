{ config, lib, ... }: {

  config =
    lib.mkIf config.services.tailscale.enable { services.tailscale = { }; };
}
