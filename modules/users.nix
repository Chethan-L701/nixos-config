{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chethan = {
    isNormalUser = true;
    description = "chethan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      # shell tools
      oh-my-posh # theme the fish prompt
      starship # The minimal, blazing-fast, and infinitely customizable prompt for any shell!
      fishPlugins.done # get exit codes
      fishPlugins.fzf-fish # fzf integration for fish shell
      zoxide # better cd

      # files
      fd # better find command
      fzf # fuzzy find tool
      yazi # neovim style tui file explorer
      tree # get the tree view of the files

      # notes and documents
      obsidian # an extensive document and note taking software
      zathura # pdf reader

      # utils
      ripgrep # better grep tool
      unzip # to extract zip files
      unrar # to extract winrar files
      lsd # prettier ls command
      gemini-cli # google gemini ai code agent
      tmux # a terminal multiplexer
      gh # cli tool to manage github
      fastfetch # prints basic info on the system and its status
      killall # uses name of the program to kill all the instance of the program running
      swww # wallpaper engine for wayland

      #cli tolls
      feh # image viewer
      bat # better cat
      peaclock # tui clock
      jq # json parsing tool
      libnotify # library for notification tools

      # compilers and language tools(lsp, debugger, build tools, etc.)
      #C/C++
      cmake # configuration tools C/C++ language
      ninja # build tool for C/C++ (alternative to make)
      nil # nix lsp
      nixd # ...

      # ides and editors
      godot # Game development software
      zed-editor # minimal gui editor
      vscode # code editor by microsoft

      # social
      thunderbird # Email client
      whatsapp-for-linux # Private messaging tool
      discord # Social Connectivity Software with channels
      betterdiscordctl # Extend Discord capabilities

      # media
      mpvc # vlc ui for mpv
      kew # tui based audio player
      kdePackages.kdenlive # video editing software
      gimp # Image editing software
      inkscape
      mpd # music player
      ncmpcpp # Featureful ncurses based MPD client inspired by ncmpc

      chromium # base chromium browser
    ];
  };
}
