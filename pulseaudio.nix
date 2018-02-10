{pkgs, ...}:
{
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
    set-card-profile alsa_card.platform-cht-bsw-rt5645 HiFi
    set-default-sink alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645_0__sink
    set-sink-port alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645_0__sink [Out] Speaker
    '';
    daemon.config = {
      realtime-scheduling = "no";
    };
  };
}
