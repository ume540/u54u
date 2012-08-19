#!/bin/bash -x
adb push out/target/product/maguro/system/bin/$1 /sdcard/$1
adb shell <<__EOT__
su
cd /system/bin
cp /sdcard/$1 $1
chmod 777 $1
exit
rm /sdcard/$1
exit
__EOT__

