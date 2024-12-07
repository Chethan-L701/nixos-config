{inputs , pkgs, config, ...} :
{
	xdg.configFile.tofi = {
		enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../tofi;
		target = "tofi";
	};	
}
