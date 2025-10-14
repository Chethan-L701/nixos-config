{ ... }:
{
  environment.variables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    NIXPKGS_ALLOW_UNFREE = "1";
    BROWSER = "firefox";
    EDITOR = "nvim";
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
  };
}
