{config, pkgs, inputs, ...}:

{
	xdg.configFile.tmux = {
		enable = true;
		source = config.lib.file.mkOutOfStoreSymlink ../tmux;
		target = "tmux";
	};	
}
