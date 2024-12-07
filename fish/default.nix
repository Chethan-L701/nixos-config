{pkgs, inputs, config, ...}: 
{
	xdg.configFile.fish = {
		enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../fish;
		target = "fish";
	};
}

