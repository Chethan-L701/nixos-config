{config, pkgs, inputs, ...} :
{
	xdg.configFile.wofi = {
		enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../wofi;
		target = "wofi";
	};
}
