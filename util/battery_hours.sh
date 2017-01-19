#!/bin/sh
BAT_E=`cat /sys/class/power_supply/BAT0/charge_now`
BAT_I=`cat /sys/class/power_supply/BAT0/current_avg`
BAT_V=`cat /sys/class/power_supply/BAT0/voltage_now`

PROG="$BAT_I * $BAT_V"
BAT_P=`echo "$PROG" | bc -l`

PROG="$BAT_E * 10000000 / $BAT_P"
echo "$PROG" | bc -l | awk '{printf "%.3f", $0}'
