#!/bin/bash

readonly WINCOUNT="$(wmctrl -l | awk '$4 !~ /^(xfce4-panel|plank|Schreibtisch)$/' | wc -l)"
readonly WINLIST="$(wmctrl -l | awk '$4 !~ /^(xfce4-panel|plank|Schreibtisch)$/' | cut -d' ' -f5-)"

INFO="<txt>"
INFO+="<span fgcolor='lightgrey'>[${WINCOUNT}] </span>"
INFO+="</txt>"

TOOL_INFO="<tool>"
TOOL_INFO+="${WINLIST}"
TOOL_INFO+="</tool>"

echo -e "${INFO}"
echo -e "${TOOL_INFO}"
