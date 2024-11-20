{ config, lib, ... }: {

  options.tailscale = {
    enable = lib.mkEnableOption "Use Tailscale VPN";
    credentialsFile = lib.mkOption {
      type = lib.types.path;
      description = "Tailscale auth token file (age-encrypted)";
    };
  };

  config = lib.mkIf config.services.tailscale.enable {
    services.tailscale = {
      openFirewall = true;
      authKeyFile = ./tailscale_auth.secret;
      extraUpFlags = [ "--ssh" ];
    };

    # Create credentials file for Cloudflare
    secrets.tailscale = {
      source = config.tailscale.credentialsFile;
      dest = "${config.secretsDirectory}/tailscale";
      owner = "jayan";
      group = "users";
      permissions = "0440";
    };

  };

}
