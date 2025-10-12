{config, ...} : {
    xdg.configFile.swaync = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ../swaync;
        target = "swaync";
    };
}
