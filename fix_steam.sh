#!/bin/bash
####################################################################################
# Name: Fix Steam Audio
# Version: 0.1
#
# This script is only a temporal solution for the bug about Pulseaudio in steam with OpenSUSE.
#
# (Author): Segundo Luis Martín Díaz Sotomayor
# (Nick): zchronos
# (Website): http://gioscix.com/bishoujolinux/
# (Email): smartinds@gmail.com
#
# IMPORTANT: You need to run this script every time you update Steam
#
#
# Date: Sep. 13, 2013
#
####################################################################################
# Start
echo "--------------------------------------------------------------------"
echo "Fix Steam Audio"
echo "Version: 0.1"
echo ""
echo "This script is only a temporal solution for the bug about Pulseaudio in steam with OpenSUSE."
echo ""
echo "THERE IS NO WARRANTY WHATSOEVER. USE AT OWN RISK!"
echo "I AM NOT RESPONSIBLE FOR ANY DAMAGE CAUSED TO YOU OR YOUR COMPUTER."
echo "--------------------------------------------------------------------"
echo ""

LOCAL_LIBRARY_PATH="/usr/lib/"
STEAM_LIBRARY_PATH="$HOME/.steam/steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/"

cheking () {
    echo "[Cheking ${1}]"
    count=$(ls -1 ${1}.so.0*| wc -l)
    archivos=$(ls ${1}.so.0*)
    echo -e "Files: $count\n\n$archivos"
}

removing () {
    echo "[Removing ${1}]"
    archivos=$(rm ${1}.so.0*)
    
}

copying () {
    echo "[Copying ${1}]"
    cp -r $LOCAL_LIBRARY_PATH${1}.so.0* $STEAM_LIBRARY_PATH
    }

# Verify if Steam app is runing
VERIFY=`ps x | awk '{print $5}' | grep steam | wc -l`

if [ $VERIFY = "0" ]; then
    echo ""
    shift
else
    echo "Steam is running!. Please close it!"
    exit 0
fi

echo "--------------------------------------------------------------------"
echo -e "Searching local libraries for PulseAudio\n"
cd $LOCAL_LIBRARY_PATH
cheking "libpulse"
echo ""
cheking "libpulse-simple"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------"
echo -e "Searching Steam libraries for PulseAudio\n"
cd $STEAM_LIBRARY_PATH
cheking "libpulse"
echo ""
cheking "libpulse-simple"
#
echo "This script will make changes in your steam folder."
echo "Are you sure? (yes/no)"
read dozo
if [ $dozo = "yes" ]; then
    echo "Starting..."
    shift
else
    exit 0
fi

removing "libpulse"
copying "libpulse"
removing "libpulse-simple"
copying "libpulse-simple"

echo "Successful"