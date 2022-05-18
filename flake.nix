{
    inputs.nixpkgs.url = "nixpkgs";

    outputs = { self, nixpkgs }: {
        lib = {
            pair = name: value: builtins.listToAttrs [{
                inherit name;
                inherit value;
            }];
        };
        modules = {
            common = import ./common.nix;
            user = { name, ... }@overrides: { ... }: {
              users.users = (lib.pair name ((import ./user.nix) // overrides));
            };
        };
    };
}
