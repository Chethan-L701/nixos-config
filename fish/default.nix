{pkgs, inputs, config, ...}: 
{
    programs.carapace = {
        enable = false;
        enableFishIntegration = true;
    };
}

