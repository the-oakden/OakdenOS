{ ... }:
{

  programs = {
    noctalia = {
      enable = true;
      settings = {

        nightLight = {
          enabled = true;
          # forced = true;
          autoSchedule = true;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "19:00";
        };

        /*
          appLauncher = {
            screenshotAnnotationTool = "be.alexandervanhee.gradia";
          };

          location = {
            weatherEnabled = true;
            useFahrenheit = true;
          };

          bar = {
            barType = "floating";
            notifications.sounds.enabled = true;
            density = "compact";
            position = "top";
            showCapsule = false;
            widgets = {
              left = [
                {
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
                {
                  id = "Network";
                }
                {
                  id = "Bluetooth";
                }
              ];
              center = [
                {
                  hideUnoccupied = false;
                  id = "Workspace";
                }
              ];
              right = [
                {
                  id = "Tray";
                }
                {
                  alwaysShowPercentage = false;
                  id = "Battery";
                  warningThreshold = 30;
                }
                {
                  formatHorizontal = "HH:mm";
                  formatVertical = "HH mm";
                  id = "Clock";
                  useMonospacedFont = true;
                  usePrimaryColor = true;
                }
              ];
            };

          };
        */
      };
    };

  };
}
