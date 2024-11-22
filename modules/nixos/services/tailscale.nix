{ config, lib, ... }: {

  options.tailscale = {
    enable = lib.mkEnableOption "Use Tailscale VPN";
    credentialsFile = lib.mkOption {
      type = lib.types.path;
      description = "Tailscale auth token file (age-encrypted)";
    };
  };

  # a = builtins.break config.tailscale.enable;

  config = lib.mkIf config.tailscale.enable {

    services.tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = "${config.secrets.tailscaled.dest}";
      extraUpFlags = [ "--ssh" ];
    };

    # Create credentials file for Tailscale
    secrets.tailscaled = {
      source = config.tailscale.credentialsFile;
      dest = "${config.secretsDirectory}/tailscaled";
      owner = "tailscaled";
      group = "tailscaled";
      permissions = "0440";
    };
  };
}
