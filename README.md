# Amlogic flash tool

This is the flash-tool for Amlogic platforms.

----------------------------

This is the flash-tool for Amlogic platforms.
This flash-tool script rely on update linux tool that need firstly to be installed.
Please read the file tools/_install_/README before to proceed here.

## Installation

Please run INSTALL.sh to install dependency and usb rules or UNINSTALL.sh to remove.

```bash
./INSTALL
```

After that run aml_flash_tool.sh , it will give you quick help :

```bash
Usage      : ./aml_flash_tool.sh --img=/path/to/aml_upgrade_package.img> --parts=<all|none|bootloader|dtb|logo|recovery|boot|system|..> [--wipe] [--reset=<y|n>] [--soc=<m8|axg|gxl|txlx|g12a>] [efuse-file=/path/to/file/location] [bootloader|dtb|logo|boot|...-file=/path/to/file/partition] [--password=/path/to/password.bin]
Version    : 4.9
Parameters : --img        => Specify location path to aml_upgrade_package.img
             --parts      => Specify which partition to burn
             --wipe       => Destroy all partitions
             --reset      => Force reset mode at the end of the burning
             --soc        => Force soc type (gxl=S905/S912,axg=A113,txlx=T962,g12a=S905X2,m8=S805/A111)
             --efuse-file => Force efuse OTP burn, use this option carefully
             --*-file     => Force overload of partition files
             --password   => Unlock usb mode using password file provid
             --destroy    => Erase the bootloader and reset the board
```

For newer amlogic boards, use adnl_flash_tool.sh :

```bash
Usage: ./adnl_flash_tool.sh -p <path-to-image>

Amlogic DNL burn package tool V[1.2] at Nov  1 2019
options:
  -p <package path>             (MustBe)Specify amlogic upgrade package path
  -s <specific device>          (Optional)Specify a DNL USB serialno, provide either
  -c <check burn ipackage>      (Optional)0 or 1, and default 0 to NO crc check image first
  -r <reboot after burn>        (Optional)0 or 1, and default 0 to NOT reboot after burn successful
  -e <erase flash>            	 (Optional)0 or 1, and default 1 to erase whole flash chip
  -b <erase boot>            	 (Optional)0 or 1, and default 1 to erase_bootloader 
  -t <device change timeout>    (Optional)unit is second, default 8, -t 0 will no timeout

```

For burning into sdcard, use sdcard_burn_tool.sh :

```bash
Usage: ./sdcard_burn_tool.sh -d </dev/sdX> -i <path-to-image>

```
