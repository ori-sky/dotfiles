#!/bin/sh
BAT_NOW=`cat /sys/class/power_supply/BAT0/energy_now`
BAT_USAGE=`cat /sys/class/power_supply/BAT0/power_now`
PROG="$BAT_NOW/$BAT_USAGE"
echo $PROG | bc -l | awk '{printf "%.1f", $0}'
