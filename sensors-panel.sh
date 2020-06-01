#!/usr/bin/env bash
readonly TEMP_FAN=$(sensors | awk '/^fan1/{$2 = $2; $3 = $3; printf("%4d %s\n", $2, $3)}; /^Package/{$4 =$4; printf $4 " "}')
readonly SENSORS=$(sensors)

INFO="<txt>"
INFO+="<span fgcolor='salmon'>🌡️${TEMP_FAN} </span>"
INFO+="</txt>"

MORE_INFO="<tool>"
MORE_INFO+="${SENSORS}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"

