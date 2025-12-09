{ ... }:
{
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      general.apps = {
        terminal = "kitty";
        explorer = "nautilus";
      };
      paths.wallpaperDir = "/etc/nixos/wallpapers";
      border.rounding = 16;
      background.visualizer = {
        enabled = false;
        blur = false;
      };
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
    };
  };
}
