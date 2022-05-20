{
  inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-21.11;
  inputs.home-manager.url = github:nix-community/home-manager;

  outputs = { self, nixpkgs, home-manager }:
  let
    root = {
      inherit home-manager;

      adaedra = {
        modules = {
          base = import ./modules/base.nix;
          user = import ./modules/user.nix;
        };
      };
    };

    genHost = name: modules: {
      inherit name;
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = (modules root);
      };
    };
  in {
    lib = {
      genHosts = hosts:
        builtins.listToAttrs (
          map
          (name: genHost name hosts."${name}")
          (builtins.attrNames hosts)
        );
    };
  };
}
