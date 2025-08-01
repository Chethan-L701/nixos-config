{inputs , pkgs, config, ...} :
{
# add the home manager module
    imports = [ inputs.ags.homeManagerModules.default ];

    programs.ags = {
        enable = true;

# symlink to ~/.config/ags
        configDir = ../ags;

# additional packages and executables to add to gjs's runtime
        extraPackages = with pkgs; [
            inputs.astal.packages.${pkgs.system}.apps
            inputs.astal.packages.${pkgs.system}.battery
            inputs.astal.packages.${pkgs.system}.cava
            inputs.astal.packages.${pkgs.system}.bluetooth
            inputs.astal.packages.${pkgs.system}.mpris
            inputs.astal.packages.${pkgs.system}.hyprland
            inputs.astal.packages.${pkgs.system}.network
            inputs.astal.packages.${pkgs.system}.tray
            fzf
        ];
    };
}
