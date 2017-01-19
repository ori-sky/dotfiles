#!/bin/sh
BAT_NOW=`cat /sys/class/power_supply/BAT0/charge_now`
BAT_FULL=`cat /sys/class/power_supply/BAT0/charge_full`
BAT_FULL_DESIGN=`cat /sys/class/power_supply/BAT0/charge_full_design`

PROG="$BAT_NOW / $BAT_FULL * 100;"
PER_NOW=`echo "$PROG" | bc -l`

PROG="$BAT_FULL / $BAT_FULL_DESIGN * 100;"
PER_FULL=`echo "$PROG" | bc -l`

echo "$PER_NOW" | awk '{printf "%.2f%% of ", $0}'
echo "$PER_FULL" | awk '{printf "%.2f%%", $0}'
