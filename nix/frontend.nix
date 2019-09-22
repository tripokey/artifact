with import ./rustOverlay.nix (import <nixpkgs>);

let
  _rust = (rustChannels.stable.rust.override { targets = [ "wasm32-unknown-unknown" ]; });
  rustPlatform = makeRustPlatform {
    cargo = _rust;
    rustc = _rust;
  };
in

rustPlatform.buildRustPackage rec {
  name = "artifact-frontend";

  patches = [ ./disable-backend.patch ];

  src = ../.;

  buildInputs = [ cargo-web ];

  doCheck = false;

  buildPhase = ''
    cargo web deploy -p artifact-frontend --release
  '';

  installPhase = ''
    mkdir -p $out
    cd target/deploy
    tar cf $out/frontend.tar *
  '';

  cargoSha256 = "18b2vv4mfnfbgi4kad08svccpkzsj8g7hlj99sr4gacxjhnvizfa";
}
