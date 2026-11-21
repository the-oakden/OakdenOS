{ pkgs }:
pkgs.writeShellScriptBin "start" ''
  systemctl --user start hyprpaper.service;
  systemctl --user restart xdg-desktop-portal;
  systemctl --user restart xdg-desktop-portal-gnome;

''
