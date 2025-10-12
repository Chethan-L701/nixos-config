# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
    system.stateVersion = "25.05";

    # Allow unfree packages
	nixpkgs.config.allowUnfree = true;

    # Enable Flakes and Nix Command
    nix.settings.experimental-features = ["nix-command" "flakes"];

	imports =
		[ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            ./services/vicinae.nix
            ./fixes.nix
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
    # virtualisation.virtualbox.host.enable = true;
    virtualisation.waydroid.enable = true;

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

    i18n.extraLocales = ["kn_IN/UTF-8" "hi_IN/UTF-8" "zh_CN.UTF-8/UTF-8"];

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
    environment.gnome.excludePackages = with pkgs; [
        gnome-online-accounts
        geary
        evolution-ews
        evolution
        evolution-data-server
        gnome-tour
        gnome-maps
        gnome-calendar
        evolutionWithPlugins
    ];
    services.gnome.gnome-online-accounts.enable = false;
    services.gnome.evolution-data-server.enable = lib.mkForce false;

    # sleep settings
	services.logind = {
        settings = {
            Login = {
                HandleLidSwitch = "ignore";
                HandleLidSwitchExternalPower = "ignore";
            };
        };
	};

    # Enable CUPS to print documents.
	services.printing.enable = true;

    # Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};
    # xwayland
    programs.xwayland.enable = true;
    # Enable Hyprland
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
        withUWSM = true;
	};
	programs.hyprlock.enable = true;

    # niri wm
    programs.niri.enable = true;

    # Install Fish Shell
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;


    # bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Experimental = true;
                # You might also want to add other settings here, like:
                # ControllerMode = "dual"; # For dual mode (BR/EDR and LE)
                # FastConnectable = true;
            };
            Policy = {
                AutoEnable = true;
            };
        };
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

    console = {
        enable = true;
        font = "ter-v20n";
        packages = [
            pkgs.terminus_font
        ];
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

        # utils
            ripgrep                                             # better grep tool
            unzip                                               # to extract zip files
            unrar                                               # to extract winrar files
            lsd                                                 # prettier ls command
            gemini-cli                                          # google gemini ai code agent
            tmux                                                # a terminal multiplexer
            gh                                                  # cli tool to manage github 
            fastfetch                                           # prints basic info on the system and its status
            # conky                                               # monitoring tool
            killall                                             # uses name of the program to kill all the instance of the program running
            swww

        # notifications
            libnotify                                           # library for notification tools

        # compilers and language tools(lsp, debugger, build tools, etc.)
            #C/C++
            cmake                                               # configuration tools C/C++ language
            ninja                                               # build tool for C/C++ (alternative to make)
            # cmake-language-server                               # LSP for cmake configuration language

            # web
            nodejs                                              # javascript runtime with npm
            emmet-ls                                            # LSP and Snippets for HTML
            bun                                                 # JS/TS runtime
            vscode-json-languageserver                          # LSP for json
            vscode-css-languageserver                           # LSP for css
            typescript-language-server                          # LSP for javascript and typescript

            # nvim and wez
            lua51Packages.lua                                   # lua language interpreter
            luajitPackages.luarocks-nix                         # luarocks : package manager for lua
            luajitPackages.jsregexp                             # lua package to create and parse JSON
            luajitPackages.magick                               # lua package for libmagick ( images )

            # rust
            rustup                                              # management tool for rust language

            # cuda
            cudaPackages.cudatoolkit                            # nvidia cuda tookit for GPU programming
            cudaPackages.cuda_cudart                            # extra cuda tools
            cudaPackages.cuda_nvcc                              # compiler for cuda

            #odin
            odin
            ols

        # ides and editors
            godot                                               # Game development software
            zed-editor                                          # minimal gui editor

        # ui
            waybar                                              # Status bar
            wofi                                                # app launcher
            tofi                                                # demu alternative
            rofi                                                # OG rofi fork for wayland
            cava                                                # Audia visualizer

        # social
            thunderbird                                         # Email client
            whatsapp-for-linux                                  # Private messaging tool
            discord                                             # Social Connectivity Software with channels
            betterdiscordctl                                    # Extend Discord capabilities

        # media
            mpvc                                                # vlc ui for mpv
            kew                                                 # tui based audio player
            kdePackages.kdenlive                                # video editing software
            gimp                                                # Image editing software
            
            chromium                                            # base chromium browser
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
    fonts = {
        fontDir.enable = true;
        packages= with pkgs;[
            material-symbols
                noto-fonts
                noto-fonts-cjk-sans
                noto-fonts-emoji
                nerd-fonts.fira-code
                nerd-fonts.jetbrains-mono
                nerd-fonts.mononoki
                nerd-fonts.ubuntu
        ];
    };

    # List packages installed in system profile. To search, run:
    environment.systemPackages = with pkgs; [
    #editors
        vscode                                                  # code editor by microsoft
        vim                                                     # vim

    #hyprland and window management tools
        hyprsunset                                              # reduce blue light from screen
        hyprlang                                                # hyprland language support
        hyprpanel                                               # status panel
        hyprland-qtutils                                        # hyprland tools
        mpvpaper                                                # wallpaper engine (static, slideshow, live video, etc.)
        hyprpaper                                               # set wallpaper (static)
        inputs.vicinae.packages.${system}.default               # open source alternative to rayband for linux
        hyprshot                                                # screenshot tool
        xdg-desktop-portal-hyprland                             # xwayland support hyprland
        xwayland-satellite                                      # niri needs it

        swaynotificationcenter                                  # a notification control center

    #camera (doesn't work) :( 
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
        jq                                                      # json parsing tool

    #compilers and co. tools
        llvmPackages.clang                                      # LLVM C/C++ language compiler
        llvmPackages.libcxx                                     # LLVM C/C++ language library
        clang-tools                                             # extra tools from llvm such formater, lsp, repl, etc for c/c++ development

    #emulation
        lutris                                                  # wrapper for wine emulation
        wineWow64Packages.full                                  # run exe files (windows apps) on linux
        protonup                                                # proton engine for emulation

    #communication and network
        networkmanagerapplet                                    # network manager tools
        libmtp                                                  # MTP protocal help file communication btw android and linux
        bluez-experimental                                      # bluetooth management tools
        bluetui                                                 # tui tool to manage bluetooth devices
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

    # keyboard and inputs
        kanata-with-cmd

    # locales, fonts and text rendering
        pango                                                   # Library for laying out and rendering of text
        harfbuzz                                                # Text shaping engine
        fontconfig                                              # Library for font customization and configuration
        material-symbols                                        # Material icons for themes and apps

    #other tools
        tesseract                                               # ocr tool
        wget                                                    # similar to curl, fetch(get) things from web
        socat                                                   # networking tool
        git                                                     # version control
        imagemagick                                             # image manipulation tool
        wl-clipboard                                            # clipboard for wayland

        # (
        #     pkgs.catppuccin-sddm.override {
        #     flavor = "mocha";
        #     font  = "Mononoki Nerd Font";
        #     fontSize = "14";
        #     background = "${/etc/nixos/wallpapers/wa_left.png}";
        #     loginBackground = true;
        #     }
        # )                                                       # catppuccin theme for sddm login screen
    ];

	environment.variables = {
        XDG_CURRENT_DESKTOP = "Hyprland";
        NIXPKGS_ALLOW_UNFREE = "1";
		BROWSER = "firefox";
		EDITOR = "nvim";
		XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
		STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
	};

    environment.sessionVariables = {
		MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
    };

    # kdeconnect
    programs.kdeconnect = {
        enable = true;
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

    services.kanata = {
        enable = true;
        keyboards = {
            all = {
                configFile = /home/chethan/.config/kanata/kanata.kbd;
                port = 6969;
            };
        };
    };

    # systemd.services.waydroid-container = {
    #     serviceConfig = {
    #         ExecStart = [
    #             "" # clears the default ExecStart
    #                 "${pkgs.waydroid}/bin/waydroid container start --hostnet"
    #         ];
    #     };
    # };


    networking = {

        nat = {
            enable = true;
            internalInterfaces = [ "waydroid0" ];
            externalInterface = "wlp4s0";
        };

        # Open ports in the firewall.
        firewall = {
            enable = true;
            allowedTCPPorts = [ 53 ];
            allowedUDPPorts = [ 53 67 ];
        };
    };
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
}
