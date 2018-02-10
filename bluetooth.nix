{pkgs, ...}:
{
  hardware.bluetooth.enable = true;
  boot.kernelModules = [ "btusb" ];
}
