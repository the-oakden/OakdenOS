{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zsh-helix-mode.url = "github:multirious/zsh-helix-mode/main";
    zsh-helix-mode.inputs.nixpkgs.follows = "nixpkgs";
    stylix = {
      # url = "github:nix-community/stylix/release-26.05";
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-mineral.url = "github:the-oakden/nix-mineral/"; 

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

    in
    {

      nixosConfigurations.smalltop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs system;
          inherit pkgs-unstable;
        };
        modules = [
          stylix.nixosModules.stylix
          ./hosts/smalltop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users = {
              user = import ./hosts/smalltop/home.nix;
            };
          }
        ];
      };

    };
}
