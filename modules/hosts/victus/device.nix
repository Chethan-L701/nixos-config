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

  boot.kernelParams = [
    "mem_sleep_default=s2idle"
    "i915.enable_psr=0"
    "i915.enable_dpcd_backlight=0"
    "i915.enable_dc=2"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
  '';

  powerManagement.enable = true;

  # TODO: Changes in the option names
  #systemd.sleep.extraConfig = ''
  #  HibernateDelaySec=1h
  #  SuspendState=mem
  #'';

  # sleep settings
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        HandlePowerKey = "hibernate";
        HandlePowerKeyLongPress = "poweroff";
      };
    };
  };

  services.acpid = {
    enable = true;
    handlers = {
      ac-power = {
        event = "ac_adapter.*";
        action = ''
          vals=($1)         
          case ''${vals[3]} in
          00000000)
              echo "ac unplugged" >> /tmp/acpi-adapter
                  ;;
          00000001)
              echo "ac plugged" >> /tmp/acpi-adapter
              ;;
          *)
              echo unknown >> /tmp/acpi-adapter
              ;;
          esac
        '';
      };
      brightnessdown = {
        event = "video/brightnessdown.*";
        action = ''
          /run/current-system/sw/bin/brightnessctl --device=intel_backlight s 5%-
          echo "brightnessdown" >> /tmp/acpi-brightness
        '';
      };
      brightnessup = {
        event = "video/brightnessup.*";
        action = ''
          /run/current-system/sw/bin/brightnessctl --device=intel_backlight s 5%+
          echo "brightnessup" >> /tmp/acpi-brightness
        '';
      };
      volumedown = {
        event = "button/volumedown.*";
        action = ''
          /run/current-system/sw/bin/sudo -u chethan \
            XDG_RUNTIME_DIR=/run/user/1000 \
            /run/current-system/sw/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          echo "volumedown">> /tmp/acpi-volume
        '';
      };
      volumeup = {
        event = "button/volumeup.*";
        action = ''
          /run/current-system/sw/bin/sudo -u chethan \
            XDG_RUNTIME_DIR=/run/user/1000 \
            /run/current-system/sw/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
          echo "volumeup">> /tmp/acpi-volume
        '';
      };
      volumemute = {
        event = "button/mute.*";
        action = ''
          /run/current-system/sw/bin/sudo -u chethan \
            XDG_RUNTIME_DIR=/run/user/1000 \
            /run/current-system/sw/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          echo "volumemute">> /tmp/acpi-volume
        '';
      };
    };
  };
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
