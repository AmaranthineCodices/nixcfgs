{ ... }:

{
  # Linode-specific LISH console settings
  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.grub.extraConfig = ''
    serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
    terminal_input serial;
    terminal_output serial
  '';

  # Partitionless disk warning suppresion as advised by Linode
  boot.loader.grub.forceInstall = true;
  boot.loader.grub.device = "nodev";
  boot.loader.timeout = 10;

  boot.loader.grub.enable = true;

  # Advised by Linode, but might revisit later.
  networking.usePredictableInterfaceNames = false;
}
