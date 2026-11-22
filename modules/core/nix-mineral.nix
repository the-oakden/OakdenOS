{ ... }: {

  nix-mineral = {
    enable = true;
    # See: https://nixos.org/manual/nixos/stable/#sec-option-definitions-setting-priorities
    preset = [
      "compatibility"
      "performance"
    ];

    settings = {
      etc.harden-bluetooth = false;
    };
  };

}
