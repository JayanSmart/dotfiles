# MixOS Config
# Base system configuration for desktop linux

{ inputs, globals, overlays, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    ../../modules/common
    ../../modules/nixos
    {
      nixpkgs.overlays = overlays;

      nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };

      networking = {
        hostName = "mixos";
        #  wireless.enable = true; # Enables wireless support via wpa_supplicant.
        networkmanager.enable = true;
      };

      # Theming
      gui.enable = true;

      theme = {
        colors = (import ../../colorscheme/gruvbox-dark).dark;
        dark = true;
      };

      # Programs and services
      neovim.enable = true;
      # media.enable = true;
      #      dotfiles.enable = true;
      firefox.enable = true;
      discord.enable = true;
      # rust.enable = true;
      gaming = { steam.enable = true; };
      #      openvpn.enable = true;
      # jellyfin -- needs modules/nixos/jellyfin/default.nix
      imports = [ ./hardware-configuration.nix ];

      boot.loader.grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
        configurationLimit = 5;
      };

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.jayan = {
        isNormalUser = true;
        description = "Jayan Smaart";
        extraGroups = [ "networkmanager" "wheel" ];
      };

    }
  ];
}
