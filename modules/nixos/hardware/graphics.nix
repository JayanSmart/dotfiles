{ config, ... }: {

  unfreePackages = [ "nvidia-x11" "nvidia-settings" ];
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Nvidia Proprietery Drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.opengl = { enable = true; };

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "za";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

}
