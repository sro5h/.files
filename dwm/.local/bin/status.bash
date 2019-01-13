#!/usr/bin/env bash

batteryPath="/sys/class/power_supply/BAT1/capacity"

while sleep 1; do
        date="$(date "+%b %d %_H:%M")"
        battery="$(cat ${batteryPath})%"
        wifi="$(iwgetid -r)"

        xsetroot -name "${wifi} ${battery} ${date}"
done
