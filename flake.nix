{
  description = "A tagging client thing.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nmattia/naersk";
  };

  outputs = { self, nixpkgs, naersk, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs { inherit system; };
      in
        {
          defaultPackage = naersk.lib.${system}.buildPackage {
            src = ./.;
            buildInputs = [
              pkgs.protobuf
              pkgs.installShellFiles
            ];
            PROTOC = "${pkgs.protobuf}/bin/protoc";
            postInstall = ''
              installShellCompletion target/release/build/tgc-*/out/tgc.{fish,bash}
              installShellCompletion --zsh target/release/build/tgc-*/out/_tgc
            '';
          };
          defaultApp = {
            type = "app";
            program = "${self.defaultPackage.${system}}/bin/tgc";
          };
        }
    );
}
