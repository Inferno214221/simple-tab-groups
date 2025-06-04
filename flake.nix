{
  description = "Simple Tab Groups";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        # buildInputs = with pkgs; [
        #     # none
        # ];
        # nativeBuildInputs = with pkgs; [
        #   nodejs_22
        # ] ++ buildInputs;
      in
      {
        devShells.default = with pkgs; mkShell {
          inherit nativeBuildInputs;
        };

        packages.default = with pkgs; buildNpmPackage rec {
          pname = "simple-tab-groups";
          version = "5.3.1-inf";
          
          src = ./addon;

          node = nodejs_22;
          npmDepsHash = "sha256-ZlxoFzNDKSf7ZQrwNyN95bq1bkjNhrgB3UJre1Sw4Uk=";
          npmBuildScript = "build-zip";

          installPhase = ''
            mkdir -p $out
            ls dist-zip
            cp ./dist-zip/simple-tab-groups@drive4ik-v5.3.1-prod.zip $out/simple-tab-groups@drive4ik.xpi
          '';

          meta = {
            description = "My themed version of simple-tab-groups";
            homepage = "https://github.com/Inferno214221/simple-tab-groups";
            license = lib.licenses.mpl20;
          };
        };
      }
    );
}
