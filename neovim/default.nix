{config, pkgs, inputs,... }: {

	nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay.default ];
	home.packages = with pkgs; [
		neovim-remote
			nixfmt-rfc-style
			luajitPackages.luarocks-nix
			lua-language-server
			luajitPackages.jsregexp
			stylua
			inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
	];

    xdg.configFile.neovim = {
        enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../neovim;
		target = "nvim";
	};

}
