# MixOS Config
# Base system configuration for desktop linux

{
  inputs,
  globals,
  overlays,
  ...
}:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    ../../modules/common
    ../../modules/nixos
    {
      nixpkgs.overlays = overlays;
      networking.hostname = "mixos";
    };

    # Theming

    gui.enable = true;

    theme = {
      colors = (import ../.../colorscheme/gruvbox-dark).dark;
      dark = true;
    };
    

    # Programs and services
    neovim.enable = true;
    media.enable = true;
    dotfiles.enable = true
    firefox.enable = true;
    discord.enable = true;
    nixlang.enable = true;
    rust.enable = true;
    gaming = {
      steam.enable = true;
    };
    openvpm.enable = true;
    # jellyfin -- needs modules/nixos/jellyfin/default.nix
  ];
};
