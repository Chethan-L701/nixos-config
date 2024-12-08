{pkgs, inputs, config, ...}: 
{
    programs.carapace = {
        enable = true;
        enableFishIntegration = true;
    };
}

