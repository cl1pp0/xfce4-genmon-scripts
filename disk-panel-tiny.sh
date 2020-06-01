#!/usr/bin/env bash
readonly USAGE=$(df | awk '/\ \/$/{printf("%.1f/%.1f GiB\n", $3/1048576, $2/1048576)}')
readonly DF=$(df -h)

INFO="<txt>"
INFO+="<span fgcolor='darkgray'>💾${USAGE} </span>"
INFO+="</txt>"

MORE_INFO="<tool>"
MORE_INFO+="${DF}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"

