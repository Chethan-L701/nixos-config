{ pkgs, ... }:
{

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    #emulation
    lutris # wrapper for wine emulation
    wineWow64Packages.full # run exe files (windows apps) on linux
    protonup # proton engine for emulation
    mangohud # a hud tool to monitor game performance stats
  ];
}
