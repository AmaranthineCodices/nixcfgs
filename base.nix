{ config, pkgs, modulesPath, inputs, ... }:

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
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrjKFC22OZRbC3g+tCus28oEsQcR/c2T7EzkZGwgKFv" ];
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  # Tailscale nameserver configuration.
  networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  networking.search = [ "tail9380d.ts.net" ];
  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  services.fail2ban = {
    enable = true;
    ignoreIP = [ "100.64.0.0/10" ];
  };

  # Remote deployment from macOS requires this. It's fine from a security
  # stance, since you have to SSH into it with a public key.
  security.sudo.wheelNeedsPassword = false;
}
