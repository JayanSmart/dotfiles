{
  config,
  pkgs,
  lib,
  ...
}:

let
  neovim = import ./package {
    inherit pkgs;
    colors = config.theme.colors;
    github = true;
  };
in
{

  options.neovim.enable = lib.mkEnableOption "Neovim.";

  config = lib.mkIf config.neovim.enable {
    home-manager.users.${config.user} = {
      home.packages = [ neovim ];

      # Use neovim to edit git commit messages
      programs.git.extraConfig.core.editor = "nvim";

      # Set neovim as the default app for text editing and man pages
      home.sessionVariables = {
        EDITOR = "nvim";
        MANPAGE = "nvim +Man!";
      };

      # Create aliases for launching neovim
      # TODO: convert example fish config to zsh

      xdg.mimeApps.defaultApplications = lib.mkIf pkgs.stdenv.isLinux {
        "text/plain" = [ "nvim.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
      };
    };
  };
}
