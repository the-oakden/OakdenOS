{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/home/fastfetch
    ../../modules/home/browsers
    ../../modules/home/starship.nix
    ../../modules/home/bash.nix
    ../../modules/home/helix
    ../../modules/home/niri
    inputs.noctalia.homeModules.default
    ../../modules/home/noctalia
    ../../modules/home/nushell.nix
    ../../modules/home/git.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home = {
    username = "user";
    homeDirectory = "/home/user";
    shellAliases = {
      cat = "bat";
    };
  };

  stylix = {
    targets = {
      helix.enable = false;
      vencord.enable = true;
      vesktop.enable = true;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "hx";
  };  

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    typst
    vscodium-fhs
    btop
    devenv
    just
    super-productivity
    blender
    tinymist
    numbat
    freecad
    octaveFull
    wl-clipboard
    tldr
    libnotify
    appimage-run
    harper
    markdown-oxide
    nerd-fonts.jetbrains-mono # JetBrains Mono NerdFont
    gimp
    kdePackages.kdenlive
    tmux
    chromium
    yazi
    lolcat
    ffmpeg
    figlet
    zoxide
    neovide
    playerctl
    nautilus
    fzf
    fuzzel
  ];

  programs = {
    bat = {
      enable = true;
    };
    yazi = {
      enable = true;
      enableNushellIntegration = true;
      shellWrapperName = "y";

    };
    ghostty = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    zed-editor.enable = true;
    alacritty.enable = true;
    neovim.enable = true;
    btop.enable = true;
    zellij.enable = true;
    fuzzel.enable = true;

    kitty = {
      enable = true;
      extraConfig = ''
        cursor_trail 900
        rursor_trail_decay 0.5 1.0
        cursor_trail_start_threshold 1
        cursor_trail_color #${config.lib.stylix.colors.base16}
      '';
    };
  };

  services = {
    opensnitch-ui.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
