{
  # `pkgs` is the NixOS package set, passed via home-manager.extraSpecialArgs
  # (with useGlobalPkgs it is not a default module arg).
  config,
  pkgs,
  ...
}:
{
  home.username = "porta";
  home.homeDirectory = "/home/porta";
  home.stateVersion = "26.05";

  programs.nh = {
    enable = true;
    flake = "/home/porta/Code/nixos-config";
  };

  # TODO: add userName/userEmail once a git identity is set up.
  programs.git.enable = true;
  programs.gh.enable = true;

  home.packages = with pkgs; [
    vesktop
    nix-output-monitor
  ];
}
