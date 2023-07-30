{
  description = "NixOS server configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = inputs: {
    nixosConfigurations.hematite = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hematite/configuration.nix ];
      specialArgs = { inherit inputs; };
    };
  };
}
