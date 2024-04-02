{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, tinycmmc }:
    tinycmmc.lib.eachWin32SystemWithPkgs (pkgs:
      {
        packages = rec {
          default = fribidi;

          fribidi = pkgs.stdenv.mkDerivation rec {
            pname = "fribidi";
            version = "1.0.12";

            src = pkgs.fetchurl {
              url = "https://github.com/fribidi/fribidi/releases/download/v${version}/${pname}-${version}.tar.xz";
              sha256 = "sha256-DNIz+X/IxnuzrCfOhEDe9dP/rPUWdluRwsxlRJgpNJU=";
            };

            doCheck = false;

            nativeBuildInputs = [
              pkgs.buildPackages.meson
              pkgs.buildPackages.ninja
              pkgs.buildPackages.pkg-config
            ];

            depsBuildBuild = [ pkgs.buildPackages.stdenv.cc ];
          };
        };
      }
    );
}
