
# aliases
alias ls='ls -G'
alias grep='grep --color=auto'

# local executable path
export PATH=${PATH}:~/local/bin

# brew
export PATH=/usr/local/bin:${PATH}

#
# nvm (node virsion control) settings
#
source ~/local/nvm/nvm.sh
nvm use v0.6.18> /dev/null
#export NODE_PATH=${NVM_PATH}_modules

#
# android sdk/ndk setting
#
ANDROID_SDK_HOME=~/local/android-sdk-macosx
export PATH=${PATH}:${ANDROID_SDK_HOME}/tools
export PATH=${PATH}:${ANDROID_SDK_HOME}/platform-tools
export PATH=${PATH}:~/local/android-ndk-r8
export PATH=${PATH}:~/local/android-toolchain-14/bin
export USE_CCACHE=1

# set the number of open files to be 1024
ulimit -S -n 1024

##
# Your previous /Users/umeda/.bash_profile file was backed up as /Users/umeda/.bash_profile.macports-saved_2012-06-12_at_07:42:48
##

# MacPorts Installer addition on 2012-06-12_at_07:42:48: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
