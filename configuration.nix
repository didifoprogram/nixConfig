# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
   
  # Use GRUB 2 
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.initrd.luks.devices = [
    {
     name = "root";
     device = "/dev/disk/by-uuid/35b7a446-5bb7-4dc1-988e-718e798ef61d";
     preLVM = true;
     allowDiscards = true;
    }
  ]; 

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  
  # Network
  networking.hostName = "dfm"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # services.resolved.enable = true;
  # networking.interfaces.eno1.ipv4.addresses = [ { address = "192.168.0.100"; prefixLength = 24; } ];
  networking.resolvconfOptions = [ "eno1" ];
  networking.dnsExtensionMechanism = false; 
  networking.nameservers = [ "208.67.220.220" "208.67.222.222" ];

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
  wget
  vim
  rxvt_unicode
  firefox
  git
  irssi
  newsboat
  zathura
  emacs
  stack
  ghc
  unzip
  mpv
  ranger
  xorg.xmodmap
  htop
  python36
  ];
  
  # JDK
  programs.java.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 80 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Window Manager
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
 
  # Fonts
  fonts.fonts = with pkgs; [ 
      pkgs.font-awesome_5 
      pkgs.hack-font 
];
  
  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.diego = {
     isNormalUser = true;
     home = "/home/diego";
     description = "Diego Mayoral";
     extraGroups = [ "wheel" "audio" ];
     uid = 1000;
  
   };

  
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
