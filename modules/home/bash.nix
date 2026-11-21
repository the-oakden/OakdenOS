{ ... }:
{
  programs.bash = {
    enable = true;

    shellAliases = {
      # Reuild with with flake in ~/OakdenOS
      nrs = "cd /etc/nixos/OakdenOS && sudo nixos-rebuild switch --flake path:. ;  notify-send -t 3000 -i face-smile \"Done Rebuilding!\"";
      # Rebuild with the flake in ~/OakdenOS and update
      viconfmain = "sudo hx ~/OakdenOS/$HOSTNAME/configuration.nix";
      viconfhome = "sudo hx ~/OakdenOs/$HOSTNAME/home.nix";
      svi = "sudo nvim";
      shx = "sudo hx";
      ff = "clear && fastfetch";
      his = "$(cat ~/.bash_history | fzf)";
      lg = "lazygit";
      t2l = "pandoc -f typst -t latex";
      l2t = "pandoc -f latex -t typst";
      t2h = "pandoc -f typst -t html";
      llm = ''
         # Resolve the exact binary path inside the devenv profile
        OPENCODE_BIN=$(which opencode 2>/dev/null || echo "")

        if [ -z "$OPENCODE_BIN" ]; then
          echo "Error: opencode is not installed in this devenv environment."
          exit 1
        fi

        # Capture the directory containing the devenv symlinks (e.g., /run/user/1000/devenv-profile)
        DEVENV_PROFILE_DIR=$(dirname "$(dirname "$OPENCODE_BIN")")

        # Ensure your LLM configurations directory exists on the host
        mkdir -p "$HOME/.config/opencode"

        bwrap \
          --ro-bind /nix/store /nix/store \
          --ro-bind /run/current-system /run/current-system \
          --ro-bind /etc/resolv.conf /etc/resolv.conf \
          --ro-bind /etc/nsswitch.conf /etc/nsswitch.conf \
          --proc /proc \
          --dev /dev \
          --dir /tmp \
          --tmpfs /tmp \
          --tmpfs "$HOME" \
          --ro-bind "$HOME/.config/opencode" "$HOME/.config/opencode" \
          --ro-bind "$DEVENV_PROFILE_DIR" "$DEVENV_PROFILE_DIR" \
          --bind "$(pwd)" /workspace \
          --chdir /workspace \
          --unshare-all \
          --share-net \
          --cap-drop ALL \
          --die-with-parent \
          -- "$OPENCODE_BIN" "$@"
      '';

    };
    initExtra = "
      fastfetch
      export EDITOR=hx
      shopt -s expand_aliases
      ";
    bashrcExtra = ''
      function y() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
       command yazi "$@" --cwd-file="$tmp"
       IFS= read -r -d ''' cwd < "$tmp"
       [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
       rm -f -- "$tmp"
      }

      export MANPAGER='nvim +Man!'


    '';
  };
}
