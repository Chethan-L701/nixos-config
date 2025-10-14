{ pkgs, ... }:
{
  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        # You might also want to add other settings here, like:
        # ControllerMode = "dual"; # For dual mode (BR/EDR and LE)
        # FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    bluez-experimental # bluetooth management tools
    bluetui # tui tool to manage bluetooth devices
  ];
}
