#!/bin/bash -x
make showcommands $1 -j1 2>&1 | tee $1.build.log

