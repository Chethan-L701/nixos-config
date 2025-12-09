{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    neovim-remote
    nixfmt-rfc-style
    lua-language-server
    stylua
    inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.neovim = {

    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    extraLuaPackages = ps: [
      ps.magick
    ];
    extraPackages = [
      pkgs.imagemagick
      pkgs.mermaid-cli
      pkgs.tectonic
      pkgs.ghostscript
      pkgs.lazygit
    ];
  };
}
