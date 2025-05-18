#!/bin/sh

export WINEPREFIX=/stuff/Games/thief/
export WINE=/home/jarrod/.local/share/lutris/runners/wine/lutris-GE-Proton8-10-x86_64/bin/wine64
export WINEARCH=win64

EXECUTABLE='Build/RoguePatcher_1.28.2.exe'

$WINE "$EXECUTABLE" "$@"