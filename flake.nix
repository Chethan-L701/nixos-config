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
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
    catppuccin.url = "github:catppuccin/nix";

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-openclaw = {
      url = "github:openclaw/nix-openclaw";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    listwindows.url = "github:Chethan-L701/listwindows";
    kanata-client.url = "github:Chethan-L701/kanata-client";
    cava-waybar-module.url = "github:Chethan-L701/cava-waybar-module";
    netscope.url = "github:Chethan-L701/netscope";
    antigravity.url = "github:Chethan-L701/antigravity-flake";
    raddebugger.url = "github:Chethan-L701/raddebugger-flake";
    treesitter-nvim.url = "github:Chethan-L701/treesitter-nvim-flake";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.victus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./modules/hosts/victus/hardware-configuration.nix
          ./modules/hosts/victus/device.nix

          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.default
          inputs.nix-index-database.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.chethan = import ./modules/homemanager/home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          {
            nixpkgs = {
              overlays = [
                inputs.nix-openclaw.overlays.default
              ];
            };
          }
        ];
      };
    };
}
