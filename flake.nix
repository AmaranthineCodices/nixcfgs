{
  description = "NixOS server configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = inputs: {
    nixosConfigurations.hematite = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./hematite/configuration.nix ];
    };
    nixosConfigurations.iolite = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./iolite/configuration.nix ];
    };
  };
}
