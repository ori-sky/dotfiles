#!/bin/sh
BAT_NOW=`cat /sys/class/power_supply/BAT0/energy_now`
BAT_FULL=`cat /sys/class/power_supply/BAT0/energy_full`
PROG="$BAT_NOW/$BAT_FULL*100;"
echo $PROG | bc -l | awk '{printf "%.1f", $0}'
