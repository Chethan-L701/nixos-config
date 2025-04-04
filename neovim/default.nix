{config, pkgs, inputs,... }: {

    home.packages = with pkgs; [
        neovim-remote
        nixfmt-rfc-style
        lua-language-server
        stylua
        inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    ];

    xdg.configFile.neovim = {
        enable = true;
        recursive = true;
        source = config.lib.file.mkOutOfStoreSymlink ../neovim;
        target = "nvim";
    };

    programs.neovim = {
        
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      extraLuaPackages = ps: [ 
          ps.magick 
      ];
      extraPackages = [ pkgs.imagemagick ];
  };
}
