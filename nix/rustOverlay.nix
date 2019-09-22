pkgs:
let
   rustOverlay = (fetchTarball https://github.com/mozilla/nixpkgs-mozilla/tarball/master);
in
pkgs { overlays = [ (import "${rustOverlay}/rust-overlay.nix") ]; }
