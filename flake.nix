{
  description = "NvChad flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
  };

  outputs = { nixpkgs, ... }:
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: rec {
        NvChad = pkgs.callPackage ./package.nix { };
        default = NvChad;
      });

      homeManagerModules = {
        default = import ./default.nix;
      };
    };
}
