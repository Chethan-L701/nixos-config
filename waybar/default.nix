{inputs , config, pkgs, ...}: 
{
	xdg.configFile.waybar = {
		enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../waybar;
		target = "waybar";
	};
}
