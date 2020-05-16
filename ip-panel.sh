#!/bin/bash

# without net mask
#readonly IP4ADDR="$(ip -family inet addr show dev enp3s0 | awk -F"[/ ]+" '/inet / {print $3}')"
#readonly IP6ADDR="$(ip -family inet6 addr show dev enp3s0 | grep inet6.*temporary | awk -F"[/ ]+" '/inet6 / {print $3}')"

# with net mask
readonly IP4ADDR="$(ip -f inet addr show dev enp0s25 | awk '/inet / { print $2 }')"
readonly IP4ADDR2="$(ip -f inet addr show dev wlp3s0 | awk '/inet / { print $2 }')"
readonly IP6ADDR="$(ip -f inet6 a | grep inet6.*temporary | awk '/inet6 / { print $2 }')"

readonly HOST="$(uname -n)"
readonly UPTIME="$(uptime | awk '{print $3}' | cut -f1 -d",")"

INFO="<txt>"
#INFO+="<span fgcolor='lightblue'>${HOST} </span>"
INFO+="<span fgcolor='gold'>${IP4ADDR} </span>"
INFO+="<span fgcolor='gold'>${IP4ADDR2} </span>"
INFO+="<span fgcolor='yellowgreen'>${IP6ADDR} </span>"
INFO+="<span fgcolor='salmon'> up ${UPTIME}</span>"
INFO+="</txt>"

TOOL_INFO="<tool>"
TOOL_INFO+="$(ip addr show | awk '/inet / { print $2 }')"
TOOL_INFO+="$(ip addr show | awk '/inet6 / { print $2 }')"
TOOL_INFO+="</tool>"

echo -e "${INFO}"
echo -e "${TOOL_INFO}"
