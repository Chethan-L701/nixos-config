{config, ...} : {
    xdg.configFile.ranger = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ../ranger;
        target = "ranger";
    };
}
