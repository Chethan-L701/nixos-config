{ pkgs, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.hostName = "nixos"; # Define your hostname.
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "waydroid0" ];
      externalInterface = "wlp4s0";
    };

    # Open ports in the firewall.
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [
        53
        67
      ];
    };
  };
  # networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet # network manager tools
    libmtp # MTP protocal help file communication btw android and linux
    wirelesstools # iwconfig, etc.,
  ];

}
