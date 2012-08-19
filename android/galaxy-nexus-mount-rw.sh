#!/bin/bash -x
echo on
adb shell su -c "mount -o rw,remount /dev/block/platform/omap/omap_hsmmc.0/by-name/system /system"

