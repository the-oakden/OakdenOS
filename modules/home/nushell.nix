{ ... }:
{
  programs.nushell = {
    enable = true;
    shellAliases = {
      # Editors
      svi = "sudo nvim";
      shx = "sudo hx";

      # Lazygit
      lg = "lazygit";

      # Pandoc conversions
      t2l = "pandoc -f typst -t latex";
      l2t = "pandoc -f latex -t typst";
      t2h = "pandoc -f typst -t html";
    };

    extraConfig = ''
      $env.config.edit_mode = "helix"
      $env.config.buffer_editor = "hx"
      $env.EDITOR = "hx"

        # Rebuild with flake in ~/OakdenOS
        def nrs [] {
          cd /etc/nixos/OakdenOS
        
          let result = (^sudo nixos-rebuild switch --flake path:. | complete)
        
          if $result.exit_code == 0 {
            ^notify-send -t 3000 -i face-smile "Done Rebuilding!"
          } else {
            print $"NixOS rebuild failed with exit code: ($result.exit_code)"
            print $result.stderr
          }
        }

        # Edit main NixOS configuration
        def viconfmain [] {
          let host = (^hostname | str trim)
          let file = ($env.HOME | path join "OakdenOS" $host "configuration.nix")

          ^sudo hx $file
        }

        # Edit Home Manager configuration
        def viconfhome [] {
          let host = (^hostname | str trim)
          let file = ($env.HOME | path join "OakdenOS" $host "home.nix")

          ^sudo hx $file
        }

        # Clear and run Fastfetch
        def ff [] {
          ^clear
          ^fastfetch
        }

        # Search Bash history with FZF and execute selection
        def his [] {
          let history_file = ($env.HOME | path join ".bash_history")

          let selected = (
            open --raw $history_file
            | ^fzf
          )

          if ($selected | is-not-empty) {
            ^bash -c $selected
          }
        }

    '';

  };

}
