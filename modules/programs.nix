{ pkgs, ... }:
{
  programs.fish.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  programs.mtr.enable = true;
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.nix-index-database.comma.enable = true;

  services.openssh.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # virtualisation.virtualbox.host.enable = true;
  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    # C / C++
    gcc
    gnumake

    #editors
    vim # vim editors
    emacs # emacs editor
    delta # diff pager

    #terminals
    ghostty # terminal emulator
    kitty # terminal emulator fallback

    # terminal plexar
    zellij
    tmux

    # nvim and wez
    lua51Packages.lua # lua language interpreter
    luajitPackages.luarocks-nix # luarocks : package manager for lua
    luajitPackages.jsregexp # lua package to create and parse JSON
    luajitPackages.magick # lua package for libmagick ( images )

    #other tools
    tesseract # ocr tool
    wget # similar to curl, fetch(get) things from web
    socat # networking tool
    bc # calculator

    direnv
    nix-direnv
  ];
}
