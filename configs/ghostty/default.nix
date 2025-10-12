{config, pkgs, inputs,...} : {
    xdg.configFile.ghostty = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ../ghostty;
        target = "ghostty";
    };
}
