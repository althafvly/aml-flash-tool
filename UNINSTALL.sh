#!/bin/bash

set -e -o pipefail

BASE=$(dirname "$(readlink -fm "$0")")
DISTRIB=$(cat /etc/lsb-release | grep "DISTRIB_ID" | awk -F "=" '{print $2}')
DISTRIB_RELEASE=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE" | awk -F "=" '{print $2}')

RULE=

RED='\033[0;31m'
RESET='\033[m'

error_msg() {
        echo -e ${RED}Error:${RESET} $1
}

echo ""
echo "==============================================="
echo ""
echo "Host PC: $DISTRIB $DISTRIB_RELEASE"
echo ""
echo "==============================================="
echo ""

echo "Removing USB rules..."

if [[ "$DISTRIB_RELEASE" =~ "12" ]]; then
        RULE="/etc/udev/rules.d/70-persistent-usb-ubuntu12.rules"
elif [[ "$DISTRIB_RELEASE" =~ "14" || "$DISTRIB_RELEASE" =~ "16" || "$DISTRIB_RELEASE" =~ "18" || "$DISTRIB_RELEASE" =~ "20" ]]; then
        RULE="/etc/udev/rules.d/70-persistent-usb-ubuntu14.rules"
else
        RULE="/etc/udev/rules.d/70-persistent-usb-ubuntu14.rules"
fi

sudo rm -f $RULE
sudo udevadm control --reload-rules

echo "Done!"

