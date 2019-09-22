with import <nixpkgs> {};

let
  frontend = (import ./nix/frontend.nix);
in
rustPlatform.buildRustPackage rec {
  name = "artifact";

  patches = [ ./nix/disable-frontend.patch ];

  src = ./.;

  doCheck = false;

  preBuild = ''
    sed -i 's|include_bytes.*|include_bytes!("${frontend}/frontend.tar");|' artifact-app/src/frontend.rs
  '';

  buildInputs = [ which mdbook pkg-config openssl];

  cargoSha256 = "1xz1jl67bh733dgx6ynfb1m634mwzgh5j6hl721sl8xsi7nndwph";
}
