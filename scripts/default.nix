{config, ...} : {
    home.file.custom_scripts = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ../scripts;
        target = "scripts";
    };
}
