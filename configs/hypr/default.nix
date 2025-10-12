{inputs, config, pkgs, ...} : {
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland.conf;
        plugins = [
            inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        ];
    };
	# xdg.configFile.hypr = {
	# 	enable = true;
	# 	source = config.lib.file.mkOutOfStoreSymlink ../hypr;
	# 	target = "hypr";
	# };
}
