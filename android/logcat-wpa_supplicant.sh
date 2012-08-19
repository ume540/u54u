#!/bin/bash -x
adb logcat -s wpa_supplicant:D | tee logcat-wpa_supplicant.log

