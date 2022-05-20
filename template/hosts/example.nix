{ adaedra, home-manager }:
with adaedra.modules; [
    # Call the modules provided
    (base { name = "example"; })
    # FIXME: For now, home-manager requires its version to be set, or we get an impure error.
    (user { name = "user"; home-manager.home.stateVersion = "21.11"; })

    # Call other modules
    home-manager.nixosModules.home-manager

    # Input a custom configuration
    {
        fileSystems."/" = {
            device = "/dev/root";
            fsType = "auto";
        };
    }
]
