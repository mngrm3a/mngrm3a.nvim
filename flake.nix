{
  description = "mngrm3a.nvim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.vimUtils.buildVimPlugin {
          name = "mngrm3a.nvim";
          src = pkgs.lib.sourceFilesBySuffices ./. [ ".lua" ];
        };

        devShells.default =
          with pkgs;
          mkShell {
            buildInputs = [
              lua-language-server
              nil
              nixfmt-rfc-style
            ];
          };
      }
    );
}
