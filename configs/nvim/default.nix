{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    neovim-remote
    nixfmt-rfc-style
    lua-language-server
    stylua
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];

  programs.neovim = {

    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraLuaPackages = ps: [
      ps.magick
    ];
    extraPackages = [ pkgs.imagemagick ];
  };
}
