# Entry point for the "nixy" system. Feature-specific settings live in ./modules.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # extra-* appends to the defaults, keeping https://cache.nixos.org in use.
    extra-substituters = [
      "https://cache.nixos-cuda.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/development.nix
    ./modules/networking.nix
    ./modules/users.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Compatibility with app data from older NixOS versions; never change this after the initial install.
  system.stateVersion = "26.05";
}
