{ pkgs }:
pkgs.writeShellScriptBin "pick-window" ''
  window_list=$(${pkgs.niri}/bin/niri msg --json windows)
  name=$(echo $window_list | ${pkgs.jq}/bin/jq -r '.[] | ."title"' | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt="Open Windows: ")
  id=$(echo $window_list | ${pkgs.jq}/bin/jq -r '.[] | ."title", ."id"' | grep "$name" -x -A 1 | grep "$name" -vx)
   
  echo $id
  echo $name

  ${pkgs.niri}/bin/niri msg action focus-window --id $id

''
