{
  description = "NixOS server configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    authorized-keys.url = "https://github.com/amaranthinecodices.keys";
    authorized-keys.flake = false;
  };

  outputs = inputs: {
    nixosConfigurations.hematite = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./base.nix, ./hematite/configuration.nix ];
      specialArgs = { inherit inputs; };
    };
  };
}
