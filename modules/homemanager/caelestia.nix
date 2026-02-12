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
      bar.tray = {
        compact = true;
      };
      paths.wallpaperDir = "/etc/nixos/wallpapers";
      border.rounding = 16;
      background = {
        enabled = false;
        visualizer = {
          enabled = false;
          blur = false;
        };
      };
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
