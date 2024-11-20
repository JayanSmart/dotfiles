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
      system.stateVersion = "23.11";

      nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };

      networking = {
        hostName = "mixos";
        #  wireless.enable = true; # Enables wireless support via wpa_supplicant.
        networkmanager.enable = true;
      };

      # Theming
      gui.enable = true;

      theme = {
        colors = (import ../../colorscheme/nord).dark;
        dark = true;
      };

      wallpaper = "${inputs.wallpapers}/gruvbox/road.jpg";
      gtk.theme.name = inputs.nixpkgs.lib.mkDefault "Adwaita-dark";

      # Programs and services
      calibre.enable = true;
      discord.enable = true;
      firefox.enable = true;
      kitty.enable = true;
      media.enable = true;
      nautilus.enable = true;
      neovim.enable = true;
      rust.enable = false;

      gaming = { steam.enable = true; };

      services = {
        devmon.enable = true;
        jellyfin.enable = true;
        udisks2.enable = true;
      };

      tailscale = {
        enable = true;
        credentialsFile = ../../private/tailscale.age;
      };

      imports = [ ./hardware-configuration.nix ];

      boot.loader.grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
        configurationLimit = 5;
      };

      #########################
      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.jayan = {
        isNormalUser = true;
        description = "Jayan Smart";
        extraGroups = [ "networkmanager" "wheel" ];
      };

      # Set your time zone.
      time.timeZone = "Europe/London";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_GB.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
    }
  ];
}
