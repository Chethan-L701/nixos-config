{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        spicetify-nix = {
            url = "github:Gerg-L/spicetify-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
        quickshell = {
            url = "github:quickshell-mirror/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        astal.url = "github:aylur/astal";
        ags.url = "github:aylur/ags"; 
    };

	outputs = inputs@{ self, nixpkgs, home-manager, spicetify-nix, ... }: let
		system = "x86_64-linux";
	in {
        nixosConfigurations.default = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [
                ./configuration.nix
                inputs.home-manager.nixosModules.default 
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;

                    home-manager.users.chethan = import ./home.nix;
                    # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                    home-manager.extraSpecialArgs = {inherit inputs;};
                }
                {
                    nixpkgs = {
                        overlays = [
                        ];
                    };
                }
            ];
        };
	};
}
