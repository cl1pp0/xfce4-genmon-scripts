#!/bin/bash

# without net mask
#readonly IP4ADDR="$(ip -family inet addr show dev enp3s0 | awk -F"[/ ]+" '/inet / {print $3}')"
#readonly IP6ADDR="$(ip -family inet6 addr show dev enp3s0 | grep inet6.*temporary | awk -F"[/ ]+" '/inet6 / {print $3}')"

# with net mask
readonly IP4AE="$(ip -f inet addr show dev enp0s25 | awk '/inet / { print $2 }')"
readonly IP4AW="$(ip -f inet addr show dev wlp3s0 | awk '/inet / { print $2 }')"
readonly IP6AE="$(ip -f inet6 addr show dev enp0s25 | awk '/inet6.*temporary.* / { print $2 }')"
readonly IP6AW="$(ip -f inet6 addr show dev wlp3s0 | awk '/inet6.*temporary.* / { print $2 }')"

#readonly HOST="$(uname -n)"
#readonly UPTIME="$(uptime | awk '{print $3}' | cut -f1 -d",")"
readonly OPTIME="$(~/scripts/getoptime | cut -f1,2 -d":")"

INFO="<txt>"
#INFO+="<span fgcolor='lightblue'>${HOST} </span>"
INFO+="🌐"
INFO+="<span fgcolor='powderblue'>${IP4AW} </span>"
INFO+="<span fgcolor='powderblue'>${IP4AE} </span>"
INFO+="<span fgcolor='lightsteelblue'>${IP6AW} </span>"
INFO+="<span fgcolor='lightsteelblue'>${IP6AE} </span>"
INFO+="<span fgcolor='goldenrod'>⌛${OPTIME}</span>"
INFO+="</txt>"

TOOL_INFO="<tool>"
TOOL_INFO+="$(ip addr show | awk '/inet / { print $2 }')"
TOOL_INFO+="$(ip addr show | awk '/inet6 / { print $2 }')"
TOOL_INFO+="</tool>"

echo -e "${INFO}"
echo -e "${TOOL_INFO}"
