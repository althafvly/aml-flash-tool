#!/bin/bash

set -e -o pipefail

ADNL_TOOL="$(dirname "$(readlink -fm "$0")")/tools/adnl/adnl_burn_pkg"

IMAGE=

RED='\033[0;31m'
RESET='\033[m'

error_msg() {
	echo -e "$RED"ERROR:"$RESET" $1
}

usage() {
	echo -e "Usage:"
	echo -e "$(basename "$0") -i <path-to-image>"
}

## Calculate time
## $1 - time in seconds
time_cal() {
	local minutes

	minutes=$(($1 / 60))

	echo "Time elapsed: $minutes minute(s)."
}

while getopts "d:i:b:Dhr" flag; do
	case $flag in
		i)
		IMAGE="$OPTARG"
		;;
		D)
		DEBUG="--debug"
		;;
		r)
		RESET_BOARD="yes"
		;;
		h)
		usage
		exit
		;;
	esac
done

if [ -z "$IMAGE" ]; then
	usage
	exit -1
fi

if [ ! -f "$IMAGE" ]; then
	error_msg "Image '$IMAGE' doesn't exist!"
	usage
	exit -1
fi

start_time=`date +%s`

if ! lsusb | grep -q "Amlogic, Inc." > /dev/null; then
	error_msg "You should put your board enter upgrade mode!"
	exit -1
fi

echo "Burning image '$IMAGE' to eMMC..."
if [ "$RESET_BOARD" == "yes" ]; then
	RESET_BOARD="-r 1"
else
	RESET_BOARD=
fi
$ADNL_TOOL -p $IMAGE ${RESET_BOARD}

end_time=`date +%s`

time_cal $(($end_time - $start_time))

echo "Done!"
date
