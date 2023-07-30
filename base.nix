{ config, pkgs, modulesPath, ... }:

{
  nix.settings = {
    auto-allocate-uids = true;
    auto-optimise-store = true;
    experimental-features = [ "flakes" "nix-command" ];
    trusted-users = [ "@wheel" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-old";
  };

  programs.command-not-found.enable = false;

  time.timeZone = "Etc/UTC";

  environment.systemPackages = with pkgs; [
    nano
    curl
  ];

  networking.networkmanager.enable = true;

  users.users.patches = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keyFiles = [ inputs.authorizedKeys ];
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };
}
