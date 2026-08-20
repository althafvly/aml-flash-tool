# Amlogic flash tool

This is the flash-tool for Amlogic platforms.

----------------------------

This flash-tool script rely on update linux tool that need firstly to be installed.

## Installation

To use this tool, you must manually install the required dependencies and set up the USB udev rules.

### 1. Install Dependencies

First, install the common dependencies required for all versions:
```bash
sudo apt update
sudo apt install libusb-dev git parted lib32z1 lib32stdc++6 libusb-0.1-4 libusb-1.0-0-dev libusb-1.0-0 ccache pv base-files linux-base
sudo update-ccache-symlinks
```

Then, install the specific `ncurses` libraries depending on your OS and version:

#### Ubuntu

**For Ubuntu (up to 23.10):**
```bash
sudo apt install libncurses5 lib32ncurses5
```

**For Ubuntu (24.04 and newer):**
```bash
sudo apt install libncurses6 lib32ncurses6
```

#### Debian

**For Debian 10 & 11:**
```bash
sudo apt install libncurses5 lib32ncurses5
```

**For Debian 12 & 13:**
```bash
sudo apt install libncurses6 lib32ncurses6
```

### 2. Install USB udev Rules

Download and apply the necessary udev rules so the tool can communicate with your device via USB: https://github.com/M0Rf30/android-udev-rules#android-udev-rules

After installing, run `aml_flash_tool.sh`. It will give you quick help:

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
