{ pkgs, ... }:
{

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad = {
    middleEmulation = true;
    naturalScrolling = true;
    tapping = true;
    disableWhileTyping = false;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.kanata = {
    enable = true;
    package = pkgs.kanata-with-cmd;
    keyboards = {
      all = {
        configFile = ../../configs/kanata.kbd;
        port = 6969;
      };
    };
  };
  systemd.services.kanata = {
    wantedBy = [ "multi-user.target" ];
    before = [
      "sddm.service"
      "display-manager.service"
    ];
  };

  environment.systemPackages = with pkgs; [
    #monitoring tools
    usbutils # tools to configure and monitor usb parts
    pciutils # tools to configure and monitor pci port in the main board
    uhubctl # manage connected usbs
    lshw # ls for hardware
    lm_sensors # sensor tools
    android-tools # tools such as adb to communicate with android
    usbguard # firewall for usb
    hwinfo # print all the hardware info
    acpi # battery monitoring and management tool
    acpid # acpi deamon
    vnstat # network monitoring tool
    ncdu # storage analysis tool
    htop # better top (task manager)
    btop # fancy htop

    # keyboard and inputs
    kanata-with-cmd
    whisper-cpp-vulkan
  ];
}
