{ pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "colorful_loop" ];
        })
      ];
      theme = "colorful_loop";
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    loader.timeout = 0;
  };

  # systemd.services.plymouth-wait = {
  #   description = "Wait for specific amount of before the going to the login screen";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "plymouth-start.service" ];
  #   before = [ "plymouth-quit.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.coreutils}/bin/sleep 5";
  #   };
  # };
}
