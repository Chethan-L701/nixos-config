{ lib, ... }:

let
  packagesToFix = [
    "allegro"
    "ipu6ep-camera-hal"
    "ipu6-camera-hal"
  ];

  # The override function remains the same
  cmakePolicyOverride =
    pkg:
    pkg.overrideAttrs (old: {
      cmakeFlags = (old.cmakeFlags or [ ]) ++ [
        "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
      ];
    });

in
{

  nixpkgs.config.packageOverrides =
    super:
    lib.listToAttrs (
      lib.map (pkgName: {
        name = pkgName;
        value = cmakePolicyOverride super.${pkgName};
      }) packagesToFix
    );

}
