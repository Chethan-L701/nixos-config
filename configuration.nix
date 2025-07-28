# Edit this configuration file to define what should be installed oncon
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
    system.stateVersion = "25.05";

    # Allow unfree packages
	nixpkgs.config.allowUnfree = true;

    # Enable Flakes and Nix Command
    nix.settings.experimental-features = ["nix-command" "flakes"];

	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
        # ./sddm/sddm-astronaut.nix
		];

    hardware.enableRedistributableFirmware = true;
    hardware.ipu6.enable = true;
    hardware.ipu6.platform = "ipu6ep";

    # Bootloader.
    hardware.firmware = with pkgs; [
        ivsc-firmware
        ipu6-camera-bins
        linux-firmware
    ];

    # boot.blacklistedKernelModules = [ "uvcvideo" ];
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelModules = ["kvm-intel" "v4l2loopback" ];
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    environment.etc.camera.source = "${pkgs.ipu6ep-camera-hal}/share/defaults/etc/camera";

	networking.hostName = "nixos"; # Define your hostname.
    networking.nameservers = ["1.1.1.1" "8.8.8.8"];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
	networking.networkmanager.enable = true;
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # virtual box
    virtualisation.virtualbox.host.enable = true;

    # Set your time zone.
	time.timeZone = "Asia/Kolkata";

    # Select internationalisation properties.
	i18n.defaultLocale = "en_IN";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_IN";
		LC_IDENTIFICATION = "en_IN";
		LC_MEASUREMENT = "en_IN";
		LC_MONETARY = "en_IN";
		LC_NAME = "en_IN";
		LC_NUMERIC = "en_IN";
		LC_PAPER = "en_IN";
		LC_TELEPHONE = "en_IN";
		LC_TIME = "en_IN";
	};

    # Enable gps location services
    services.gpsd = {
        enable = true;
        # devices = [ "/dev/ttyACM0" ];
        # extraArgs = [ "-n" ]; # optional: tells gpsd to start reading even if no client is connected
    };

    # Enable the X11 windowing system.
	services.xserver.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;
    services.libinput.touchpad = {
        middleEmulation = true;
        naturalScrolling = true;
        tapping = true;
        disableWhileTyping = false;
    };

    # Enable the SDDM Display Manager.
    # services.displayManager.sddm = {
    #     enable = true;
    #     package = pkgs.kdePackages.sddm;
    # };

    # Enable the GDM Display Manager.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs.gnome; [
    ];

    # sleep settings
	services.logind = {
		lidSwitch = "ignore";
		lidSwitchExternalPower = "ignore";
	};

    # Enable CUPS to print documents.
	services.printing.enable = true;

    # Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

    # Enable Hyprland
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
        withUWSM = true;
	};
	programs.hyprlock.enable = true;

    # Install Fish Shell
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;

    # bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};

    # Graphics And Graphics Driver Settings
	hardware.graphics.enable = true;

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = true;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.beta;
		prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
            # sync.enable = true;
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
	};

    # Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
	};


    # Flatpak
    services.flatpak.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.chethan = {
		isNormalUser = true;
		description = "chethan";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
        # shell tools
            oh-my-posh                                          # theme the fish prompt 
            fishPlugins.done                                    # get exit codes
            fishPlugins.fzf-fish                                # fzf integration for fish shell
            zoxide                                              # better cd

        # files
            fd                                                  # better find command
            fzf                                                 # fuzzy find tool
            yazi                                                # neovim style tui file explorer
            tree                                                # get the tree view of the files

        # notes and documents
            obsidian                                            # an extensive document and note taking software
            zathura                                             # pdf reader
            texliveFull                                         # view the live latex preview while editing
            texpresso                                           # latex tools

        # utils
            ripgrep                                             # better grep tool
            unzip                                               # to extract zip files
            unrar                                               # to extract winrar files
            lsd                                                 # prettier ls command
            gemini-cli                                          # google gemini ai code agent
            tmux                                                # a terminal multiplexer
            gh                                                  # cli tool to manage github 
            fastfetch                                           # prints basic info on the system and its status
            conky                                               # monitoring tool
            killall                                             # uses name of the program to kill all the instance of the program running

        # notifications
            dunst                                               # a notification deamon
            libnotify                                           # library for notification tools

        # compilers and language tools(lsp, debugger, build tools, etc.)
            nodejs                                              # javascript runtime with npm
            rustup                                              # management tool for rust language
            lua51Packages.lua                                   # lua language interpreter
            cmake                                               # configuration tools C/C++ language
            cmake-language-server                               # LSP for cmake configuration language
            ninja                                               # build tool for C/C++ (alternative to make)
            emmet-ls                                            # LSP and Snippets for HTML
            vscode-json-languageserver                          # LSP for json
            vscode-css-languageserver                           # LSP for css
            typescript-language-server                          # LSP for javascript and typescript
            bun                                                 # JS/TS runtime
            cudaPackages.cudatoolkit                            # nvidia cuda tookit for GPU programming
            cudaPackages.cuda_cudart                            # extra cuda tools
            cudaPackages.cuda_nvcc                              # compiler for cuda
            luajitPackages.luarocks-nix                         # luarocks : package manager for lua
            luajitPackages.jsregexp                             # lua package to create and parse JSON
            luajitPackages.magick                               # lua package for libmagick ( images )

        # ides
            godot                                               # Game development software

        # ui
            waybar                                              # Status bar
            wofi                                                # app launcher
            tofi                                                # demu alternative
            cava                                                # Audia visualizer

        # social
            whatsapp-for-linux                                  # Private messaging tool
            discord                                             # Social Connectivity Software with channels
            betterdiscordctl                                    # Extend Discord capabilities

        # media
            mpvc                                                # vlc ui for mpv
            kew                                                 # tui based audio player
            kdePackages.kdenlive                                # video editing software
            gimp                                                # Image editing software
		];
	};

    # Install firefox.
    programs.firefox = {
        enable = true;
    };

	programs.dconf.enable = true;

    # Steam
    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;


    # Install Fonts
	fonts.packages= with pkgs;[
		nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.mononoki
	];

    # List packages installed in system profile. To search, run:
    environment.systemPackages = with pkgs; [
    #editors
        vscode                                                  # code editor by microsoft
        vim                                                     # vim
        emacs                                                   # emacs

    #hyprland and window management tools
        hyprsunset                                              # reduce blue light from screen
        hyprlang                                                # hyprland language support
        hyprpanel                                               # status panel
        hyprland-qtutils                                        # hyprland tools
        mpvpaper                                                # wallpaper engine (static, slideshow, live video, etc.)
        inputs.quickshell.packages.${pkgs.system}.default       # to create widgets using QML
        hyprshot                                                # screenshot tool
        xdg-desktop-portal-hyprland                             # xwayland support hyprland
        hyprpaper                                               # set wallpaper (static)

    #camera (doesn't work)
        v4l-utils
        gst_all_1.gstreamer
        gst_all_1.icamerasrc-ipu6ep
        ipu6ep-camera-hal
        libcamera
        ipu6-camera-bins
        ipu6-camera-hal
        linuxPackages.ipu6-drivers

    #terminals
        ghostty                                                 # terminal emulator
        kitty                                                   # terminal emulator fallback

    #media
        ffmpeg                                                  # vidoe codecs and other manipulation tools
        obs-studio                                              # screen recording
        mpv                                                     # playing video and audio

    #cli tolls
        feh                                                     # image viewer
        bat                                                     # better cat
        peaclock                                                # tui clock

    #compilers and co. tools
        llvmPackages.clang                                      # LLVM C/C++ language compiler
        llvmPackages.libcxx                                     # LLVM C/C++ language library
        clang-tools

    #emulation
        lutris                                                  # wrapper for wine emulation
        wineWow64Packages.full                                  # run exe files (windows apps) on linux
        protonup                                                # proton engine for emulation

    #communication and network
        networkmanagerapplet                                    # network manager tools
        libmtp                                                  # MTP protocal help file communication btw android and linux
        bluez                                                   # bluetooth management tools
        wirelesstools                                           # iwconfig, etc.,
        openssl                                                 # openssl library

    #monitoring tools
        usbutils                                                # tools to configure and monitor usb parts
        pciutils                                                # tools to configure and monitor pci port in the main board
        uhubctl                                                 # manage connected usbs
        lshw                                                    # ls for hardware
        nvtopPackages.nvidia                                    # monitor nvidia GPU usage
        nvtopPackages.intel                                     # monitor intel GPU usage
        lm_sensors                                              # sensor tools
        android-tools                                           # tools such as adb to communicate with android
        usbguard                                                # firewall for usb
        hwinfo                                                  # print all the hardware info
        acpi                                                    # battery monitoring and management tool
        acpid                                                   # acpi deamon
        vnstat                                                  # network monitoring tool
        ncdu                                                    # storage analysis tool
        htop                                                    # better top (task manager)

    #ctl
        pavucontrol                                             # pulse audio volume control
        brightnessctl                                           # control the screen brightness
        playerctl                                               # media controls for next, prev , puase , play , etc.

    #other tools
        tesseract                                               # ocr tool
        wget                                                    # similar to curl
        git                                                     # version control
        imagemagick                                             # image manipulation tool
        wl-clipboard                                            # clipboard for wayland

        (
            pkgs.catppuccin-sddm.override {
            flavor = "mocha";
            font  = "Mononoki Nerd Font";
            fontSize = "14";
            background = "${/etc/nixos/wallpapers/wa_left.png}";
            loginBackground = true;
            }
        )                                                       # catppuccin theme for sddm login screen
    ];

	environment.variables = {
        XDG_CURRENT_DESKTOP = "Hyprland";
        NIXPKGS_ALLOW_UNFREE = "1";
		BROWSER = "firefox";
		EDITOR = "nvim";
		MOZ_ENABLE_WAYLAND = "1";
		XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
		STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
        RANGER_LOAD_DEFAULT_RC = "FALSE";
	};

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    # gvfs
    services.gvfs.enable = true;

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
}
