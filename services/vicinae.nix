{ config, pkgs, lib, inputs, ... }:
{
    systemd.user.services.vicinae = {
        enable = true;
        description = "vicinae server deamon";
        wantedBy = [ "graphical-session.target" ];
        bindsTo = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
            Environment = "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/chethan/bin:/var/lib/flatpak/exports/bin";
            ExecStart = "${inputs.vicinae.packages.${pkgs.system}.default}/bin/vicinae server";
            Restart = "always";
            RestartSec = 5;
            KillMode = "process";
        };
    };
}
