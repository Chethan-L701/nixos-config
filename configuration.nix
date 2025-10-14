{ ... }:

{
  system.stateVersion = "25.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Enable Flakes and Nix Command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./modules/hardware/graphics.nix
    ./modules/hardware/io.nix
    ./modules/hardware/bluetooth.nix
    ./modules/hardware/networking.nix
    ./modules/hardware/media.nix

    ./modules/desktop/gnome.nix
    ./modules/desktop/wm.nix

    ./modules/users.nix
    ./modules/programs.nix
    ./modules/fonts.nix
    ./modules/gaming.nix
    ./modules/locales.nix
    ./modules/fixes.nix
    ./modules/variables.nix

    ./modules/services/vicinae.nix
  ];
}
