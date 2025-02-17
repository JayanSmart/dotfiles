# # Edit this configuration file to define what should be installed on
# # your system.  Help is available in the configuration.nix(5) man page
# # and in the NixOS manual (accessible by running ‘nixos-help’).
#
# { config, pkgs, ... }:
#
# {
#   imports = [
#     # Include the results of the hardware scan.
#     ./hardware-configuration.nix
#   ];
#
#   nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };
#
#   # Bootloader.
#   boot.loader.grub = {
#     enable = true;
#     device = "/dev/nvme0n1";
#     useOSProber = true;
#     configurationLimit = 5;
#   };
#
#   #  networking.hostName = "mixos"; # Define your hostname.
#
#   # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
#
#   # Configure network proxy if necessary
#   # networking.proxy.default = "http://user:password@proxy:port/";
#   # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
#
#   # Enable networking
#   #  networking.networkmanager.enable = true;
#
#   # Set your time zone.
#   time.timeZone = "Europe/London";
#
#   # Select internationalisation properties.
#   i18n.defaultLocale = "en_GB.UTF-8";
#
#   i18n.extraLocaleSettings = {
#     LC_ADDRESS = "en_GB.UTF-8";
#     LC_IDENTIFICATION = "en_GB.UTF-8";
#     LC_MEASUREMENT = "en_GB.UTF-8";
#     LC_MONETARY = "en_GB.UTF-8";
#     LC_NAME = "en_GB.UTF-8";
#     LC_NUMERIC = "en_GB.UTF-8";
#     LC_PAPER = "en_GB.UTF-8";
#     LC_TELEPHONE = "en_GB.UTF-8";
#     LC_TIME = "en_GB.UTF-8";
#   };
#
#   # Enable the X11 windowing system.
#   services.xserver.enable = true;
#
#   # Enable Nvidia Proprietery Drivers
#   services.xserver.videoDrivers = [ "nvidia" ];
#   hardware.opengl.enable = true;
#   hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
#
#   # Enable the KDE Plasma Desktop Environment.
#   services.xserver.displayManager.sddm.enable = true;
#   services.xserver.desktopManager.plasma5.enable = true;
#
#   # Configure keymap in X11
#   services.xserver = {
#     layout = "za";
#     xkbVariant = "";
#   };
#
#   # Enable CUPS to print documents.
#   services.printing.enable = true;
#
#   # Enable sound with pipewire.
#   sound.enable = true;
#   hardware.pulseaudio.enable = false;
#   security.rtkit.enable = true;
#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#     # If you want to use JACK applications, uncomment this
#     #jack.enable = true;
#
#     # use the example session manager (no others are packaged yet so this is enabled by default,
#     # no need to redefine it in your config for now)
#     #media-session.enable = true;
#   };
#
#   # Enable touchpad support (enabled default in most desktopManager).
#   # services.xserver.libinput.enable = true;
#
#   # Define a user account. Don't forget to set a password with ‘passwd’.
#   users.users.jayan = {
#     isNormalUser = true;
#     description = "Jayan Smaart";
#     extraGroups = [ "networkmanager" "wheel" ];
#     packages = with pkgs; [
#       firefox
#       kate
#       vlc
#       libvlc
#       #  thunderbird
#     ];
#   };
#
#   # Enable automatic login for the user.
#   services.xserver.displayManager.autoLogin.enable = true;
#   services.xserver.displayManager.autoLogin.user = "jayan";
#
#   # Allow unfree packages
#   nixpkgs.config.allowUnfree = true;
#
#   # List packages installed in system profile. To search, run:
#   # $ nix search wget
#   environment.systemPackages = with pkgs; [
#     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#     wget
#     jellyfin
#     jellyfin-web
#     jellyfin-ffmpeg
#     openvpn
#     htop
#   ];
#
#   #################################
#   # Games and game related config #
#   #################################
#
#   #programs.steam = {
#   #  enable = true;
#   #  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
#   #  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#   #};
#
#   #################################
#   # Jellyfin                      #
#   #################################
#   services.jellyfin = {
#     enable = true;
#     openFirewall = true;
#   };
#
#   # Some programs need SUID wrappers, can be configured further or are
#   # started in user sessions.
#   # programs.mtr.enable = true;
#   # programs.gnupg.agent = {
#   #   enable = true;
#   #   enableSSHSupport = true;
#   # };
#
#   # List services that you want to enable:
#
#   # Enable the OpenSSH daemon.
#   # services.openssh.enable = true;
#
#   # Open ports in the firewall.
#   # networking.firewall.allowedTCPPorts = [ ... ];
#   # networking.firewall.allowedUDPPorts = [ ... ];
#   # Or disable the firewall altogether.
#   # networking.firewall.enable = false;
#
#   # This value determines the NixOS release from which the default
#   # settings for stateful data, like file locations and database versions
#   # on your system were taken. It‘s perfectly fine and recommended to leave
#   # this value at the release version of the first install of this system.
#   # Before changing this value read the documentation for this option
#   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
#   system.stateVersion = "23.11"; # Did you read the comment?
# }
