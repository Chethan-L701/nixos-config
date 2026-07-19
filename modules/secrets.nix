{ config, pkgs, ... }:
{
  sops = {
    # Default sops file containing encrypted secrets
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # Automatically decrypt using the host's SSH keys converted to age keys
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # Declare secrets to be managed by sops
    secrets = {
      gemini-api-key = {
        owner = "chethan";
      };
      discord-bot-token = {
        owner = "chethan";
      };
    };
  };

  # Add helper packages to edit and debug secrets
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
}
