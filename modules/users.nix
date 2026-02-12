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
      tmux # a terminal multiplexer
      gh # cli tool to manage github
      fastfetch # prints basic info on the system and its status
      killall # uses name of the program to kill all the instance of the program running
      swww # wallpaper engine for wayland
      pywal # generate wallpaper based color schemes
      file # give the file info

      # CLI tolls
      feh # image viewer
      chafa # image viewer in terminal
      bat # better cat
      peaclock # tui clock
      jq # json parsing tool
      libnotify # library for notification tools

      # Compilers and language tools(lsp, debugger, build tools, etc.)

      #C/C++
      cmake # configuration tools C/C++ language
      ninja # build tool for C/C++ (alternative to make)
      #nix
      nil # nix lsp
      nixd # ...
      nh # nix search
      # json
      vscode-json-languageserver
      prettier

      # python
      python3
      pyright

      # haskell
      ghc
      haskell-language-server

      # ides and editors
      zed-editor # minimal gui editor
      vscode
      # (blender.override { cudaSupport = true; })

      # social
      discord # Social Connectivity Software with channels
      betterdiscordctl # Extend Discord capabilities

      # kdePackages.kdenlive
      gimp # Image editing software
      inkscape # svg editor

      # Browser
      chromium # base chromium browser
    ];
  };
}
