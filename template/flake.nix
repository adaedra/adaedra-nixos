{
  inputs.adaedra.url = github:adaedra/adaedra-nixos;

  outputs = { self, adaedra }: {
    nixosConfigurations = adaedra.lib.genHosts {
      # Define your hosts here
      example = import ./hosts/example.nix;
    };
  };
}
