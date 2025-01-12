{ lib
    , qtbase
        , qtsvg
        , qtgraphicaleffects
        , qtquickcontrols2
        , wrapQtAppsHook
        , stdenvNoCC
        , fetchFromGitHub
}: {
    sddm-astronaut = stdenvNoCC.mkDerivation
        rec {
            pname = "tokyo-night-sddm";
            version = "1..0";
            dontBuild = true;
            src = fetchFromGitHub {
                "owner" = "Keyitdev";
                "repo" =  "sddm-astronaut-theme";
                "rev" = "11c0bf6147bbea466ce2e2b0559e9a9abdbcc7c3";
                "hash" = "sha256-gBSz+k/qgEaIWh1Txdgwlou/Lfrfv3ABzyxYwlrLjDk=";
            };
            nativeBuildInputs = [
                wrapQtAppsHook
            ];

            propagatedUserEnvPkgs = [
                qtbase
                    qtsvg
                    qtgraphicaleffects
                    qtquickcontrols2
            ];

            installPhase = ''
                mkdir -p $out/share/sddm/themes
                cp -aR $src $out/share/sddm/themes/sddm-astronaut-theme
                '';

        };
}
