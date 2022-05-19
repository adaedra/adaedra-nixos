{
  inputs.nixpkgs.url = "nixpkgs";
  inputs.home-manager.url = github:nix-community/home-manager;

  outputs = { self, nixpkgs, home-manager }:
  let
    modules = {
      base = import ./modules/base.nix;
      user = import ./modules/user.nix;
    };
    root = {
      inherit home-manager;

      adaedra = { inherit modules; };
    };

    genHost = { name, modules }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = (modules root);
    };
  in {
    lib = {
      inherit genHost;
    };
  };
}
