{ pkgs, ... }: {
  programs.git = {
    enable = true;

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Oakden";
        email = "249669099+the-oakden@users.noreply.github.com";
      };
      commit.gpgsign = true;
      safe.directory = [
        "/etc/nixos/OakdenOS"
      ];
      tag.gpgSign = true;
      gpg.format = "ssh";
    };
  };
}
