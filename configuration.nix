# Edit this configuration file to define what should be installed oncon
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
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
    boot.blacklistedKernelModules = [ "uvcvideo" ];
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelModules = ["kvm-intel"];
    environment.etc.camera.source = "${pkgs.ipu6ep-camera-hal}/share/defaults/etc/camera";


# Enable Flakes and Nix Command
	nix.settings.experimental-features = ["nix-command" "flakes"];

	networking.hostName = "nixos"; # Define your hostname.
    networking.nameservers = ["1.1.1.1" "8.8.8.8"];
#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
	networking.networkmanager.enable = true;
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
    services.gpsd.enable = true;

# Enable the X11 windowing system.
	services.xserver.enable = true;

# Touchpad configuration

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
    #     theme = "catppuccin-mocha";
    #     package = pkgs.kdePackages.sddm;
    # };
# Enable the GDM Display Manager.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs.gnome; [
    ];

# Enable Hyprland
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
        withUWSM = true;
	};
	programs.hyprlock.enable = true;

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

# Enable CUPS to print documents.
	services.printing.enable = true;

# Graphics And Graphics Driver Settings
	hardware.graphics.enable = true;

# bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};

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

# Enable touchpad support (enabled default in most desktopManager).


# sleep settings
	services.logind = {
		lidSwitch = "ignore";
		lidSwitchExternalPower = "ignore";
	};

# Flatpak
    services.flatpak.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.chethan = {
		isNormalUser = true;
		description = "chethan";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [


#terminal emulator

# shell
				oh-my-posh
				fishPlugins.done
				fishPlugins.fzf-fish
                zoxide

# utils
				ripgrep
                obsidian
                zathura
                texliveFull
                texpresso
				fd
				lshw
				htop
				tmux
				fzf
				lf
                ranger
				tree
				gh
				pavucontrol
				brightnessctl
				wl-clipboard
				nvtopPackages.nvidia
				nvtopPackages.intel
				acpi
				acpid
				fastfetch
				ncdu
				fastfetch
				conky
				vnstat
				playerctl
				radeontop
				android-tools
				usbguard
				hwinfo
				lm_sensors
				killall
				kdePackages.kdenlive
                gimp
				tofi
				ffmpeg
				hyprshot
# notifications
				dunst
				libnotify

# compilers
				cmake
                cmake-language-server
				ninja
                nodejs
				bun
				cudaPackages.cudatoolkit
                cudaPackages.cuda_cudart
				cudaPackages.cuda_nvcc
				rustup
                lua51Packages.lua
                luajitPackages.luarocks-nix
                luajitPackages.jsregexp
                luajitPackages.magick

# ui
				waybar
				wofi
				xdg-desktop-portal-hyprland
				hyprpaper      

# social
				whatsapp-for-linux
				discord
				betterdiscordctl
				];
	};

# Install firefox.


    nixpkgs.overlays =
        let
        # Change this to a rev sha to pin
        moz-rev = "master";
        moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";};
        nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
        in [
            nightlyOverlay
        ];
    programs.firefox = {
        enable = true;
        package= pkgs.latest.firefox-bin;
    };

	programs.dconf.enable = true;


# Install Fish Shell
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;

# Steam

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# Install Fonts

	fonts.packages= with pkgs;[
		nerd-fonts.fira-code
			nerd-fonts.jetbrains-mono
			nerd-fonts.mononoki
	];

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
        linuxPackages.ipu6-drivers
        v4l-utils
        gst_all_1.gstreamer
        gst_all_1.icamerasrc-ipu6ep
        ipu6ep-camera-hal
        vscode
        vim         
        hyprlang
        hyprpanel
        hyprland-qtutils
        libmtp
        ghostty
        wget
        git
        cava	
        kitty
        ipu6-camera-bins
        ipu6-camera-hal
        openssl
        peaclock
        bluez
        wirelesstools
        lutris
        wineWow64Packages.full
        obs-studio
        usbutils
        uhubctl
        imagemagick
        protonup
        feh
        bat
        mpvpaper
        tesseract
        llvmPackages.clang
        llvmPackages.libcxx
        clang-tools
        (
            pkgs.catppuccin-sddm.override {
            flavor = "mocha";
            font  = "Mononoki Nerd Font";
            fontSize = "14";
            background = "${./wallpapers/wa_left.png}";
            loginBackground = true;
            }
        )
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

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

#gvfs

services.gvfs.enable = true;

# Enable the OpenSSH daemon.
services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.05"; # Did you read the comment?
}
