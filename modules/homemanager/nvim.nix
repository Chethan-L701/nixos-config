{ pkgs, inputs, ... }:
let
  tsRuntime = inputs.treesitter-nvim.lib.mkRuntime {
    pkgs = pkgs;
    languages = [
      "c"
      "cpp"
      "rust"
      "nix"
    ];
  };
in
{

  home.packages = with pkgs; [
    neovim-remote
    nixfmt
    lua-language-server
    stylua
    inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = true;
    withNodeJs = true;
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
    initLua = ''
      require("plugins.lazy")
      require("core")
      vim.opt.runtimepath:prepend("${tsRuntime}")
    '';
  };
}
