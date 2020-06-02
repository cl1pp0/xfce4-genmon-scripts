#!/usr/bin/env bash
readonly TEMP_FAN=$(sensors | awk '/^Package/{temp = $4}; /^fan1/{fan=$2}; END {if (fan==0) fan="----"; printf("%s %4s rpm\n", temp, fan);}')
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

