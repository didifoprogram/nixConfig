# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Network
  networking.hostName = "dfm"; # Define your hostname.
  # services.resolved.enable = true;
  # networking.interfaces.eno1.ipv4.addresses = [ { address = "192.168.0.100"; prefixLength = 24; } ];
  networking.resolvconfOptions = [ "eno1" ];
  networking.dnsExtensionMechanism = false; 

  # Select internationalisation properties.
  i18n = {
  consoleFont = "Lat2-Terminus16";
  consoleKeyMap = "us";
  defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	wget
	emacs
	chromium
	alacritty 
	git
	leiningen
	clojure
	xorg.xmodmap
        zathura
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  #Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;
  
  #Enable stumpwm
  services.xserver.windowManager.stumpwm.enable = true;

  # Compton
  services.compton.enable = true;
  services.compton.refreshRate = 144;


  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.diego = {
     isNormalUser = true;
     home = "/home/diego";
     extraGroups = ["wheel"];
     createHome = true;
     uid = 1000;
     shell = "/run/current-system/sw/bin/zsh";
   };

   programs.zsh.ohMyZsh.enable = true;
   programs.zsh.ohMyZsh.theme = "fishy";

  nix.package = pkgs.nixUnstable;
  
  fonts.fonts = with pkgs; [
	dejavu_fonts
	hack-font
	];  




# This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
