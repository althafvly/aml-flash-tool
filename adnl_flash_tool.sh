#!/bin/bash

set -e -o pipefail

ADNL_TOOL="$(dirname "$(readlink -fm "$0")")/tools/adnl/adnl_burn_pkg"

RED='\033[0;31m'
RESET='\033[m'

error_msg() {
	echo -e "$RED"ERROR:"$RESET" $1
}

usage() {
	echo -e "$($ADNL_TOOL)"
}

## Calculate time
## $1 - time in seconds
time_cal() {
	local minutes
	minutes=$(($1 / 60))
	echo "Time elapsed: $minutes minute(s)."
}

start_time=`date +%s`

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    usage
    exit -1
fi

if ! lsusb | grep -q "Amlogic, Inc." > /dev/null; then
	error_msg "You should put your board enter upgrade mode!"
	exit -1
fi

$ADNL_TOOL $@

end_time=`date +%s`

time_cal $(($end_time - $start_time))

echo "Done!"
date
