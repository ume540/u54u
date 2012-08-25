#!/bin/bash -x

WLANIF=$1
ESSID=$2
FREQ=2.412G
WLANADDR=192.168.100.101

sudo ifconfig ${WLANIF} down
sudo iwconfig ${WLANIF} mode ad-hoc
sudo iwconfig ${WLANIF} essid "${ESSID}"
sudo iwconfig ${WLANIF} freq ${FREQ}
sudo ifconfig ${WLANIF} up
sudo ifconfig ${WLANIF} ${WLANADDR}

