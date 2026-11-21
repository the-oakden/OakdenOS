{
  config,
  pkgs,
  ...
}:
{
  # Enable SANE for document scanning
  hardware = {
    # Enable document scanning with SANE
    sane.enable = true;

    # Enable printing
    printers = {
    };
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  # Enable avahi so that the printer can be found
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
}
