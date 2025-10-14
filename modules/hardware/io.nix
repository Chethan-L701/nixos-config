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

  # sleep settings
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
      };
    };
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
    keyboards = {
      all = {
        configFile = /home/chethan/.config/kanata/kanata.kbd;
        port = 6969;
      };
    };
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

    # keyboard and inputs
    kanata-with-cmd
  ];
}
