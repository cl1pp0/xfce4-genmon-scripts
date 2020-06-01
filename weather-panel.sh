#!/bin/bash

readonly WHEATHER="$(curl -s wttr.in/?format="%c%t+%h+%w")"
readonly WHEATHER_TOOL="$(curl -s wttr.in/?format="%l:+%c+%t+%h+%w+%p+%P+%S+%s")"

INFO="<txt>"
INFO+="<span fgcolor='darkseagreen'>${WHEATHER}</span>"
INFO+="</txt>"

TOOL_INFO="<tool>"
TOOL_INFO+="${WHEATHER_TOOL}"
TOOL_INFO+="</tool>"

echo -e "${INFO}"
echo -e "${TOOL_INFO}"

