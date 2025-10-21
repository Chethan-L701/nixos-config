{ pkgs, ... }:
{
  # configure sddm-astronaut theme
  nixpkgs.overlays = [
    (self: super: {
      sddm-astronaut = super.sddm-astronaut.override {
        embeddedTheme = "astronaut";
        themeConfig = {
          FormPosition = "right";
        };
      };
    })
  ];

  #enable sddm

  services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [ sddm-astronaut ];
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtsvg
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
    kdePackages.qtwayland
  ];
}
