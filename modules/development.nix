{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    claude-code
    vscodium
    nixfmt
    nixd
  ];
}
