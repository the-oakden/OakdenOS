{
  config,
  pkgs,
  ...
}:
{
  stylix = {

    enable = true;
    image = ../../wallpapers/Old_Man.jpg;
    polarity = "dark";

    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };

    opacity = {
      terminal = 0.70;
    };
  };
}
