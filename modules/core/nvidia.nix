{ lib, ... }:
{
  hardware = {
    graphics.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
    };
  };

  allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ ];

  services.xserver.videoDrivers = [ "nvidia" ];

}
