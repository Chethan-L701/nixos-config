{config, ...} : {
    xdg.configFile.dunst = {
        enable = true;
        target = config.lib.file.mkOutOfStoreSymlink ../dunst;
        target = "dunst";
    };
}
