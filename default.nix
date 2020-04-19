{ naersk, protobuf, installShellFiles }:
let
  src = builtins.filterSource
    (path: type: type != "directory" || builtins.baseNameOf path != "target")
    ./.;
in
naersk.buildPackage {
  inherit src;
  buildInputs = [
    protobuf
    installShellFiles
  ];
  PROTOC = "${protobuf}/bin/protoc";
  postInstall = ''
    installShellCompletion target/release/build/tgc-*/out/tgc.{fish,bash}
    installShellCompletion --zsh target/release/build/tgc-*/out/_tgc
  '';
}
