{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can change the word unstable to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      # NOTE: 'nixos' is the default hostname
      nixosConfigurations.nixy = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # With useGlobalPkgs, `pkgs` isn't a module arg inside home modules;
            # pass the system package set explicitly so home.nix can use it.
            home-manager.extraSpecialArgs.pkgs = pkgs;
            home-manager.users.porta = import ./home.nix;
            home-manager.backupFileExtension = "hm-backup";
          })
        ];
      };
    };
}
