{ ... }:
{
  xdg.desktopEntries = {
    firefoxNV = {
      name = "Firefox (dGPU + VAAPI)";
      icon = "firefox";
      genericName = "Web Browser";
      exec = "env LIBVA_DRIVER_NAME=nvidia __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia MOZ_ENABLE_WAYLAND=1 MOZ_DISABLE_RDD_SANDBOX=1 firefox --name firefox %U";
      terminal = false;
      categories = [
        "Network"
        "WebBrowser"
      ];
      mimeType = [
        "text/html"
        "text/xml"
      ];
    };

    zenNV = {
      name = "zen (dGPU + VAAPI)";
      icon = "zen-browser";
      genericName = "Web Browser";
      exec = "env LIBVA_DRIVER_NAME=nvidia __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia MOZ_ENABLE_WAYLAND=1 MOZ_DISABLE_RDD_SANDBOX=1 zen-beta --name zen-beta %U";
      terminal = false;
      categories = [
        "Network"
        "WebBrowser"
      ];
      mimeType = [
        "text/html"
        "text/xml"
      ];
    };
  };
}
