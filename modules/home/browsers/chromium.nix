{
  pkgs,
  ...
}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    # extensions = [
    #   "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
    #   "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
    # ];
  };
}
