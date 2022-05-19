{ name, home-manager ? {}, ... }@attributes:
let
  overrides = (builtins.removeAttrs attributes ["name" "home-manager"]);
in {
  users.users."${name}" = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" ];
  } // overrides;

  home-manager.users."${name}" = home-manager;
}
