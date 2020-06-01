#!/usr/bin/env bash
readonly USAGE=$(free -m | awk '/^[Mm]em/{printf("%.1f/%.1f GiB", ($2-$7)/1024, $2/1024) }')
readonly MEMINFO=$(head -8 /proc/meminfo)

INFO="<txt>"
INFO+="<span fgcolor='gainsboro'>💻${USAGE} </span>"
INFO+="</txt>"

MORE_INFO="<tool>"
MORE_INFO+="${MEMINFO}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
