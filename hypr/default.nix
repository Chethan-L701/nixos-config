{inputs, config, pkgs, ...} : {
	xdg.configFile.hypr = {
		enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../hypr;
		target = "hypr";
	};
}
