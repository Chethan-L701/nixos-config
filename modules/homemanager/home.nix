{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  configFiles = [
    "starship.toml"
  ];

  configDirs = [
    "niri"
    "hypr"
    "waybar"
    "tofi"
    "wofi"
    "tmux"
    "swaync"
    "kitty"
    "ghostty"
    "nvim"
    "yazi"
  ];
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "chethan";
  home.homeDirectory = "/home/chethan";

  imports = [
    ./nvim.nix
    ./nushell.nix
    ./spicetify.nix
    inputs.catppuccin.homeModules.catppuccin
    inputs.vicinae.homeManagerModules.default
    inputs.zen-browser.homeModules.beta
  ];

  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = [
    inputs.listwindows.packages.${pkgs.system}.default
    inputs.kanata-client.packages.${pkgs.system}.default
    inputs.cava-waybar-module.packages.${pkgs.system}.default
  ];

  home.file = { };

  home.activation.linkConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "Linking the configs from /etc/nixos/configs/ to $HOME/.config"

    for dir in ${lib.concatStringsSep " " configDirs}; do

        if [ -z $dir ] || [ $dir == "." ] || [ $dir == ".." ]; then
            continue
        fi

        src="/etc/nixos/configs/$dir" 
        dest="$HOME/.config/$dir"

        if [ ! -d "$src" ]; then
            echo "could not find the config for $dir in /etc/nixos/configs, skipping"
            continue
        fi
       
        echo "Linking $src to $dest"
        rm -rf "$dest"
        ln -sfT "$src" "$dest"
        echo "successfully linked $src to dest"
    done

    for file in ${lib.concatStringsSep " " configFiles}; do

        if [ -z $file ] || [ $file == "." ] || [ $file == ".." ]; then
            continue
        fi

        src="/etc/nixos/configs/$file" 
        dest="$HOME/.config/$file"

        if [ ! -f "$src" ]; then
            echo "could not find the config for $file in /etc/nixos/configs, skipping"
            continue
        fi
       
        echo "Linking $src to $dest"
        rm -f "$dest"
        ln -sfT "$src" "$dest"
        echo "successfully linked $src to $dest"
    done

  '';

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
  };

  catppuccin.gtk = {
    icon = {
      accent = "mauve";
      enable = true;
      flavor = "mocha";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
  };
  programs.zen-browser.enable = true;

  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      faviconService = "twenty";
      theme.name = "catppuccin-mocha";
      font.size = 12;
      rootSearch.searchFiles = true;
      popToRootOnClose = true;
      window = {
        csd = true;
        opacity = 0.90;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
