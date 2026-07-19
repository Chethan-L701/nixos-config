{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.openclaw = {
    enable = true;

    # Run OpenClaw gateway via systemd user service (Linux)
    systemd.enable = true;

    # Install openclaw-reload helper for config refresh + gateway restart without sudo
    reloadScript.enable = true;

    # --- OpenClaw Runtime Plugins (JavaScript/npm roots loaded by Gateway) ---
    runtimePlugins = [
      "discord"
    ];

    # --- Bundled Tool Plugins (Nix-packaged CLI/Skill integrations) ---
    bundledPlugins = {
      summarize.enable = true; # Summarize web pages, PDFs, videos
      goplaces.enable = true; # Google Places API
      gogcli.enable = true; # Google Calendar
      sag.enable = true; # Text-to-speech

      # Note: peekaboo (screenshot tool) is macOS-only and cannot be enabled on Linux.
      peekaboo.enable = false; # Screenshot your screen (macOS only)

      discrawl.enable = false; # Discord archive/search
      wacrawl.enable = false; # WhatsApp archive/search
      poltergeist.enable = false; # File watching and automation
      camsnap.enable = false; # Camera snapshots
      sonoscli.enable = false; # Sonos control
      imsg.enable = false; # iMessage
    };

    # --- Runtime environment variables ---
    environment = {
      GEMINI_API_KEY = "/run/secrets/gemini-api-key";
      DISCORD_BOT_TOKEN = "/run/secrets/discord-bot-token";
    };

    # --- OpenClaw Configuration (upstream schema-typed shape) ---
    config = {
      # Setup local memory backend (QMD)
      memory.backend = "qmd";

      commands = {
        ownerAllowFrom = [ "discord:551415873114603522" ];
      };
      # Gateway Settings
      gateway = {
        mode = "local";
      };

      # Configure Google/Gemini Provider using the environment variable
      models.providers.google.apiKey = {
        source = "env";
        provider = "default";
        id = "GEMINI_API_KEY";
      };

      # Set Gemini as the default model for all agents
      agents.defaults.model = {
        primary = "google/gemini-3.1-pro-preview";
      };

      # Configure Discord Channel using the environment variable
      channels.discord = {
        enabled = true;
        token = {
          source = "env";
          provider = "default";
          id = "DISCORD_BOT_TOKEN";
        };
      };
    };
  };
}
