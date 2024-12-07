{inputs, config, pkgs, ...} :
{
	xdg.configFile.kitty = {
		enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../kitty;
		target = "kitty";
	};
}
