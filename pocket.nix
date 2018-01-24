{ pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    ./kernel.nix
    ./firmware
    ./xserver.nix
    ./bluetooth.nix
    ./touch.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    kdeFrameworks.networkmanager-qt
  ];
  nixpkgs.config.allowUnfree = true; # for firmware

  # neet 4.14+ for proper hardware support (and modesetting)
  # especially for screen rotation on boot
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_gpd_pocket;
  boot.initrd.kernelModules = [
    "pwm-lpss"
    "pwm-lpss-platform" # for brightness control
    # "g_serial" # be a serial device via OTG
  ];
  networking.networkmanager.enable = true;

  # force off to avoid during image building
  networking.wireless.enable = lib.mkForce false;
  services.xserver.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.tlp.enable = true;

  # Select internationalisation properties.
  i18n = {
   consoleFont = "Lat2-Terminus16";
   consoleKeyMap = "us";
   defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
}
