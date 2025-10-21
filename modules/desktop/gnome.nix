{ pkgs, lib, ... }:
{
  # Enable the GDM Display Manager.
  # services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gvfs.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-online-accounts
    geary
    evolution-ews
    evolution
    evolution-data-server
    gnome-tour
    gnome-maps
    gnome-calendar
    evolutionWithPlugins
  ];

  services.gnome.gnome-online-accounts.enable = false;
  services.gnome.evolution-data-server.enable = lib.mkForce false;
}
