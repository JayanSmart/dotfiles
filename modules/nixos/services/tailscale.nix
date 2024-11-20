{ config, lib, ... }: {

  options.tailscale = {
    enable = lib.mkEnableOption "Use Tailscale VPN";
    credentialsFile = lib.mkOption {
      type = lib.types.path;
      description = "Tailscale auth token file (age-encrypted)";
    };
  };

  config = lib.mkIf config.services.tailscale.enable {

    # Create credentials file for Tailscale
    secrets.tailscale = {
      source = config.tailscale.credentialsFile;
      dest = "${config.secretsDirectory}/tailscale";
      owner = "jayan";
      group = "users";
      permissions = "0440";
    };

    services.tailscale = {
      openFirewall = true;
      authKeyFile = "${config.secrets.tailscale.dest}";
      extraUpFlags = [ "--ssh" ];
    };

  };

}
