#
# Usage:
#   $(CMD) branch-name
#
# Parameters:
#   branch-name : android source code branch name.
#                   e.g. android-4.0.1_r1
#

ANDROID_ROOT=~/proj/android-kernel

# create case-sensitive file-system disk.
hdiutil create -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size 30g ${ANDROID_ROOT}/$1.dmg
open ${ANDROID_ROOT}/$1.dmg
ln -s /Volumes/$1 ${ANDROID_ROOT}/$1

# set limit number of open file
ulimit -S -n 1024

# install GNU GPG
brew install gnupg

# install repo
curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > ~/local/bin/repo
chmod a+x ~/local/bin/repo
PATH=${PATH}:~/local/bin

# goto source directory.
pushd ${ANDROID_ROOT}/$1

# retrive android source
repo init -u https://android.googlesource.com/platform/manifest
repo sync -j8

# build all
#   please specify DevType and BuildType with lunch.
source build/envsetup.sh
lunch full-eng
make -j4

popd

