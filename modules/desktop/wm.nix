{ pkgs,inputs, ... }:
{

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # xwayland
  programs.xwayland.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  programs.hyprlock.enable = true;

  # niri wm
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    #hyprland and window management tools
    hyprsunset # reduce blue light from screen
    hyprlang # hyprland language support
    hyprpanel # status panel
    hyprland-qtutils # hyprland tools
    mpvpaper # wallpaper engine (static, slideshow, live video, etc.)
    hyprpaper # set wallpaper (static)
    inputs.vicinae.packages.${system}.default # open source alternative to rayband for linux
    hyprshot # screenshot tool
    xdg-desktop-portal-hyprland # xwayland support hyprland
    xwayland-satellite # niri needs it

    # ui elements and other tools
    swaynotificationcenter # a notification control center
    waybar # Status bar
    wofi # app launcher
    tofi # demu alternative
    rofi # OG rofi fork for wayland
    cava # Audia visualizer
    wl-clipboard # clipboard for wayland
  ];
}
