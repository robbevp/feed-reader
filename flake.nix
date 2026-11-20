{
  description = "A flake to run feed reader";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs }:
    {
      packages = builtins.mapAttrs
        (system: pkgs: {
          feed-reader = pkgs.callPackage ./default.nix { revision = inputs.self.rev; };
          default = self.packages.${system}.feed-reader;
        })
        nixpkgs.legacyPackages;
      overlays.default = (
        self: super: { feed-reader = self.callPackage ./default.nix { revision = inputs.self.rev; }; }
      );
      nixosModules = rec {
        feed-reader = import ./module.nix;
        default = feed-reader;
      };
    };
}
