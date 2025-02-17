{ config, pkgs, lib, ... }: {

  options = {
    discord = {
      enable = lib.mkEnableOption {
        description = "Enable Discord.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.discord.enable) {
    unfreePackages = [ "discord" ];
    environment.systemPackages = [ pkgs.discord ];
    home-manager.users.${config.user} = {
      xdg.configFile."discord/settings.json".text = ''
        {
          "BACKGROUND_COLOR": "#202225",
          "IS_MAXIMIZED": false,
          "IS_MINIMIZED": true,
          "OPEN_ON_STARTUP": true,
          "MINIMIZE_TO_TRAY": true,
          "SKIP_HOST_UPDATE": true
        }
      '';
    };
  };
}
