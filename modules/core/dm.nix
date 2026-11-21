{
  ...
}:
{
  services.displayManager = {
    # ly.enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
      autoLogin = {
        enable = true;
        user = "user";
      };
    };
  };
}
