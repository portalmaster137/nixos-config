{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
    flatpak.enable = true;
    ollama.enable = true;
  };

  programs = {
    firefox.enable = true;
    steam = {
      enable = true;
      protontricks.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wine
  ];
}
