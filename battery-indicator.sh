#!/usr/bin/env bash
echo $(cat /sys/class/power_supply/BAT0/capacity)%
# pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'
