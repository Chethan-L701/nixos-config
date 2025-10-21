{ pkgs, ... }:
{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.mpris ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    ffmpeg # vidoe codecs and other manipulation tools
    obs-studio # screen recording
    mpv # playing video and audio
    pavucontrol # pulse audio volume control
    brightnessctl # control the screen brightness
    playerctl # media controls for next, prev , puase , play , etc.
    imagemagick # image manipulation tool
  ];
}
