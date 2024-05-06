{ config, pkgs, lib, ... }: {

  users.users.${config.user}.shell = pkgs.fish;
  programs.fish.enable = true; # Needed for LightDM to remember username

  home-manager.users.${config.user} = {

    # Packages used in abbreviations and aliases
    home.packages = with pkgs; [ curl ];

    programs.fish = {
      enable = true;

      shellAliases = {

        # Version of bash which works much better on the terminal
        bash = "${pkgs.bashInteractive}/bin/bash";

        # Use eza (exa) instead of ls for fancier output
        ls = "${pkgs.eza}/bin/eza --group";

        # Move files to XDG trash on the commandline
        trash = lib.mkIf pkgs.stdenv.isLinux "${pkgs.trash-cli}/bin/trash-put";
      };

      shellAbbrs = {

        # Directory aliases
        l = "ls -lh";
        lh = "ls -lh";
        ll = "ls -alhF";
        la = "ls -a";
        c = "cd";
        "-" = "cd -";
        mkd = "mkdir -pv";

        # System
        s = "sudo";
        sc = "systemctl";
        scs = "systemctl status";
        m = "make";
        t = "trash";

        # Vim (overwritten by Neovim)
        v = "vim";
        vl = "vim -c 'normal! `0'";

        # Notes
        sn = "syncnotes";

        # Fun CLI Tools
        weather = "curl wttr.in/$WEATHER_CITY";
        moon = "curl wttr.in/Moon";

        # Cheat Sheets
        ssl =
          "openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr";
        fingerprint = "ssh-keyscan myhost.com | ssh-keygen -lf -";
        publickey = "ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub";
        forloop = "for i in (seq 1 100)";

        # Docker
        dc = "$DOTS/bin/docker_cleanup";
        dr = "docker run --rm -it";
        db = "docker build . -t";
      };
      shellInit = "";
    };

    home.sessionVariables.fish_greeting = "";

    programs.fzf.enableFishIntegration = true;
  };
}
