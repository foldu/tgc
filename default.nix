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
  PROTOC = "${pkgs.protobuf}/bin/protoc";
  postInstall = ''
    installShellCompletion target/release/build/${bin}-*/out/${bin}.{fish,bash}
    installShellCompletion --zsh target/release/build/${bin}-*/out/_${bin}
  '';
}
