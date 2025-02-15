# Protea
# Home server IntelNUC

{
  inputs,
  globals,
  overlays,
  ...
}:

inputs.nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = { };
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    ../../modules/common
    ../../modules/nixos
    {
      nixpkgs.overlays = overlays;

      # Hardware
      server = true;
      physical = true;
      networking.hostName = "protea";

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm_intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/f0e4415d-9235-4bbb-b4eb-3c12b86a4757";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/57FA-64DC";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      hardware.enableRedistributableFirmware = true;

      hardware.cpu.intel.updateMicrocode = true;

      swapDevices = [ ];

      # networking.useDHCP = lib.mkDefault true;

      # Theming

      # No gui on server
      gui.enable = false;

      theme = {
        colors = (import ../../colorscheme/gruvbox-dark).dark;
      };

      # Programs and services
      neovim.enable = true;

      services = {
        # devmon.enable = true;
        plex.enable = true;
        # udisks2.enable = true;
      };

      # tailscale = {
      #   enable = true;
      #   credentialsFile = ../../private/tailscale.age;
      # };

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      #########################
      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.jayan = {
        isNormalUser = true;
        description = "Jayan Smart";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
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
