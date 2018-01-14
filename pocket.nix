{ pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    #./wifi.nix
    ./kernel.nix
    ./firmware
  ];
  
  environment.systemPackages = with pkgs; [
    vim
  ];
  nixpkgs.config.allowUnfree = true; # for firmware

  # neet 4.14+ for proper hardware support (and modesetting)
  # especially for screen rotation on boot
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_gpd_pocket;
  boot.initrd.kernelModules = [
    "pwm-lpss" "pwm-lpss-platform" # for brightness control
    "g_serial" # be a serial device via OTG
  ];
  networking.networkmanager.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];


  users.users = {
    andi = {
      isNormalUser = true;
      name = "jakob";
      uid = 1337;
      shell = pkgs.zsh;
      extraGroups = ["wheel" "networkmanager" "docker" "cdrom" "dialout"];
    };
  };

}
