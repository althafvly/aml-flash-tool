#!/bin/bash

set -e -o pipefail

FLASH_TOOL="flash-tool.sh"

IMAGE=
DEVICE=
BOARD=
IMAGE_INSTALL_TYPE=

RED='\033[0;31m'
RESET='\033[m'

error_msg() {
	echo -e "$RED"ERROR:"$RESET" $1
}

usage() {
	echo -e "Usage:"
	echo -e "sdcard: $0 -d </dev/sdX> -i <path-to-image>"
}

flash_sdcard() {
	pv -tpreb ${IMAGE} | sudo dd of=${DEVICE} conv=notrunc
	echo "Sync..."
	sync
}

## Calculate time
## $1 - time in seconds
time_cal() {
	local minutes

	minutes=$(($1 / 60))

	echo "Time elapsed: $minutes minute(s)."
}

while getopts "d:i:b:Dh" flag; do
	case $flag in
		d)
		DEVICE="$OPTARG"
		;;
		i)
		IMAGE="$OPTARG"
		;;
		D)
		DEBUG="--debug"
		;;
		h)
		usage
		exit
		;;
	esac
done

if [ ! -f "$IMAGE" ]; then
	error_msg "Image '$IMAGE' doesn't exist!"
	usage
	exit -1
fi

partition=$(fdisk -l "$IMAGE" | grep "Disklabel type" | awk -F ": " '{print $2}' || true)
if [ "$partition" == "dos" ]; then
	IMAGE_INSTALL_TYPE="SD-USB"
fi

start_time=`date +%s`

if [ $DEVICE ]; then
	if [ ! -b $DEVICE ]; then
		error_msg "'$DEVICE' is not a block device! Please make sure the device you choose is right."
		exit -1
	fi

	if [ "$IMAGE_INSTALL_TYPE" != "SD-USB" ]; then
		error_msg "Try to burn to SD/USB storage,but the image installation type is '$IMAGE_INSTALL_TYPE', please use 'SD-USB' image!"
		exit -1
	fi

	echo "Burning image '$IMAGE' to SD/USB storage..."
	flash_sdcard
fi

end_time=`date +%s`

time_cal $(($end_time - $start_time))

echo "Done!"
date
