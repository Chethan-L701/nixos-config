{inputs , pkgs, config, ...} :
{
	xdg.configFile.omp = {
		enable = true;
        recursive = true;
		source = config.lib.file.mkOutOfStoreSymlink ../omp;
		target = "omp";
	};
}
