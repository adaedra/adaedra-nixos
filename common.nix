{ pkgs, ... }: {
    nix.package = pkgs.nixFlakes;
    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';

    programs.zsh = {
        enable = true;
        interactiveShellInit = ''
            bindkey -e
        '';
    };
    users.defaultUserShell = pkgs.zsh;

    hardware.enableRedistributableFirmware = true;
    hardware.cpu.intel.updateMicrocode = true;

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    services.openssh.enable = true;
    services.openssh.extraConfig = ''
        ClientAliveInterval 60
    '';
    networking.firewall.enable = false;

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;
    programs.neovim.configure = {
        customRC = ''
            set bg=dark
	    set number
	    set sw=4 sts=4 et ai
	'';

	packages.system = with pkgs.vimPlugins; {
            start = [ vim-nix ];
	};
    };
}
