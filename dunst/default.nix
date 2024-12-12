{config, ...} : {
    xdg.configFile.dunst = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ../dunst;
        target = "dunst";
    };
}
