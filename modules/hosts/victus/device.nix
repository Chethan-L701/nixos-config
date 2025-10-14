{ config, pkgs, ... }:
{

  hardware.enableRedistributableFirmware = true;
  hardware.ipu6.enable = true;
  hardware.ipu6.platform = "ipu6ep";

  # Bootloader.
  hardware.firmware = with pkgs; [
    ivsc-firmware
    ipu6-camera-bins
    linux-firmware
  ];

  # boot.blacklistedKernelModules = [ "uvcvideo" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "kvm-intel"
    "v4l2loopback"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  environment.etc.camera.source = "${pkgs.ipu6ep-camera-hal}/share/defaults/etc/camera";

  environment.systemPackages = with pkgs; [
    #camera (doesn't work) :(
    v4l-utils
    gst_all_1.gstreamer
    gst_all_1.icamerasrc-ipu6ep
    ipu6ep-camera-hal
    libcamera
    ipu6-camera-bins
    ipu6-camera-hal
    linuxPackages.ipu6-drivers
  ];

  # Enable gps location services
  services.gpsd = {
    enable = true;
    # devices = [ "/dev/ttyACM0" ];
    # extraArgs = [ "-n" ]; # optional: tells gpsd to start reading even if no client is connected
  };
}
