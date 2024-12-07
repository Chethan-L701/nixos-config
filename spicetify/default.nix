{
  pkgs,
  inputs,
  config,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  # import the flake's module
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  # configure spicetify :)
  programs.spicetify = rec {
    spicetifyPackage = pkgs.spicetify-cli;
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      localFiles
      marketplace
      ncsVisualizer
    ];
    enabledExtensions = with spicePkgs.extensions; [
    ];
  };
}
