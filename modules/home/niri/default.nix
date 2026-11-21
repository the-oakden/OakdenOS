{
  config,
  ...
}:
{

  home.file = {
    ".config/niri/config.kdl" = {
      text = ''

        spawn-sh-at-startup "noctalia msg wallpaper-set ${config.stylix.image}"
        include "binds.kdl"
        include "window_rules.kdl" 
        include "etc.kdl"

        layout {
          gaps 6
          // background-color "transparent"
          focus-ring {
              active-gradient from="#${config.lib.stylix.colors.base08}" to="${config.lib.stylix.colors.base16}"
              inactive-gradient from="#${config.lib.stylix.colors.base08}" to="${config.lib.stylix.colors.base16}"
              width 4
          }
        }
      '';
    };

    ".config/niri/binds.kdl".source = ./binds.kdl;
    ".config/niri/window_rules.kdl".source = ./window_rules.kdl;
    ".config/niri/etc.kdl".source = ./etc.kdl;

  };

}
