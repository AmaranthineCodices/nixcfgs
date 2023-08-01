{ config, pkgs, inputs, ... }:

{
  imports = [
    ../base.nix
    ../linode.nix
    inputs.disko.nixosModules.disko
  ];

  disko.devices = import ./disk-configuration.nix {
    lib = inputs.nixpkgs.lib;
  };

  networking.hostName = "iolite";
}
