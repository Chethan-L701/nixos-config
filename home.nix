{ config, pkgs, inputs,... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
		home.username = "chethan";
        home.homeDirectory = "/home/chethan";

        imports = [
            ./configs/neovim
            ./configs/tmux
            ./configs/hypr
            ./configs/kitty
            ./configs/ghostty
            ./configs/swaync
            ./configs/tofi
            ./configs/wofi
            ./configs/omp
            ./configs/nushell
            ./configs/spicetify
            ./scripts 
            inputs.catppuccin.homeModules.catppuccin
        ];
        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
		home.stateVersion = "24.11"; # Please read the comment before changing.
        # The home.packages option allows you to install Nix packages into your
        # environment.
        home.packages = [
            inputs.listwindows.packages.${pkgs.system}.default
            inputs.kanata-client.packages.${pkgs.system}.default
        ];

        # Home Manager is pretty good at managing dotfiles. The primary way to manage
        # plain files is through 'home.file'.
		home.file = {
            # # Building this configuration will create a copy of 'dotfiles/screenrc' in
            # # the Nix store. Activating the configuration will then make '~/.screenrc' a
            # # symlink to the Nix store copy.
            # ".screenrc".source = dotfiles/screenrc;

            # # You can also set the file content immediately.
            # ".gradle/gradle.properties".text = ''
            #   org.gradle.console=verbose
            #   org.gradle.daemon.idletimeout=3600000
            # '';
		};

        # Home Manager can also manage your environment variables through
        # 'home.sessionVariables'. These will be explicitly sourced when using a
        # shell provided by Home Manager. If you don't want to manage your shell
        # through Home Manager then you have to manually source 'hm-session-vars.sh'
        # located at either
        #
        #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        #
        # or
        #
        #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
        #
        # or
        #
        #  /etc/profiles/per-user/chethan/etc/profile.d/hm-session-vars.sh

		home.sessionVariables = {
				EDITOR = "nvim";
				MANPAGER = "nvim +Man!";
		};
		gtk = {
				enable = true;
				cursorTheme = {
						name = "catppuccin-mocha-dark-cursors";
						package = pkgs.catppuccin-cursors.mochaDark;
				};
		};
        catppuccin.gtk = {
            icon = {
                accent = "mauve";
                enable = true;
                flavor = "mocha";
            };
        };
		home.pointerCursor = {
				gtk.enable = true;
				x11.enable = true;
				name = "catppuccin-mocha-dark-cursors";
				package = pkgs.catppuccin-cursors.mochaDark;
				size = 24;
		}; 
        
        # Let Home Manager install and manage itself.
		programs.home-manager.enable = true;
}
