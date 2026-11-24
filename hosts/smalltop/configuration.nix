# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ./stylix.nix
    ../../modules/core/printing.nix
    ../../modules/core/dm.nix
    ../../modules/core/time.nix
    inputs.nix-mineral.nixosModules.nix-mineral
    ../../modules/core/nix-mineral.nix
    ../../modules/core/syncthing.nix
    ../../modules/core/flatpak.nix
  ];

  nixpkgs.config = {
    allowUnfree = false;
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "firefox-esr-140-bin-unwrapped"
      ]; # Bootloader.

    permittedInsecurePackages = [
      "firefox-esr-140-bin-unwrapped-140.17.0esr"
    ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  networking.hostName = "smalltop"; # Define your hostname.

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # services.desktopManager.plasma6.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    user = {
      isNormalUser = true;
      description = "user";
      extraGroups = [
        "networkmanager"
        "podman"
        "wheel"
      ];
      shell = pkgs.nushell;
    };
    trey = {
      isNormalUser = true;
      description = "user";
      extraGroups = [
        "networkmanager"
        "podman"
        "wheel"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    mediawriter
    sioyek
    proton-vpn-cli
    (import ../../scripts/niri-window-picker.nix { inherit pkgs; })
    (import ../../scripts/start.nix { inherit pkgs; })
    pandoc
    karp
    kdePackages.dolphin
    # xdg-desktop-portal
    # xdg-desktop-portal-wlr
    organicmaps
    zellij
    keepassxc
    presenterm
    naps2
    onlyoffice-desktopeditors
    nixd
    nixfmt
    lazygit
    rclone-ui
    zotero
    ly
    nerd-fonts.jetbrains-mono
    opensnitch-ui
    zathura
    podman-compose
    podman-desktop
    podman-tui
    opensnitch
    mpv
    kiwix
    obs-studio
    cool-retro-term
    home-manager
    open-sans
    anki
    brightnessctl
    xwayland-satellite
  ];

  programs = {
    niri = {
      enable = true;
      package = pkgs-unstable.niri;
    };
  };

  # services.desktopManager.cosmic.enable = true;
  services = {
    # blueman.enable = true;
    upower.enable = true;
    dbus.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
  };

  hardware = {
    opentabletdriver.enable = true;
    bluetooth.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
