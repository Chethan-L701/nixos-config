{ pkgs, ... }:
{
  # tty fonts
  console = {
    enable = true;
    font = "ter-v20n";
    packages = [
      pkgs.terminus_font
    ];
  };

  # Install Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      material-symbols
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.mononoki
      nerd-fonts.ubuntu
    ];
  };

  environment.systemPackages = with pkgs; [
    # locales, fonts and text rendering
    pango # Library for laying out and rendering of text
    harfbuzz # Text shaping engine
    fontconfig # Library for font customization and configuration
    material-symbols # Material icons for themes and apps
  ];
}
