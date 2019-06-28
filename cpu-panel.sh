#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk, grep, lm_sensors, sed, xfce4-taskmanager

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
readonly ICON="${DIR}/icons/cpu/chip.png"

# Array of available logical CPUs
declare -r CPU_ARRAY=($(awk '/MHz/{print $4}' /proc/cpuinfo | cut -f1 -d"."))
# Number of logical CPU
readonly NUM_OF_CPUS="${#CPU_ARRAY[@]}"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="┌ $(grep "model name" /proc/cpuinfo | cut -f2 -d ":" | sed -n 1p | sed -e 's/^[ \t]*//')\n" # CPU vendor, model, clock
STEP=0 # to generate CPU numbers (eg. CPU0, CPU1 ...)
for CPU in "${CPU_ARRAY[@]}"; do
  STDOUT=$(( STDOUT + CPU ))
  MORE_INFO+="├─ CPU ${STEP}: ${CPU} MHz\n"
  let STEP+=1
done
#TEMP=$(sensors | awk '/[Cc]ore\ 0/{print $3}' | tr -d "+°C")
TEMP=$(sensors | awk '/[Pp]ackage\ id\ 0/{print $4}' | tr -d "+°C")
MORE_INFO+="└─ Temperature: ${TEMP}°C"
MORE_INFO+="</tool>"
CLOCK=$(( STDOUT / NUM_OF_CPUS )) # calculate average clock speed
STDOUT=${CLOCK}
STDOUT=$(awk '{$1 = $1 / 1000; printf "%.2f%s", $1, " GHz"}' <<< "${STDOUT}")

# Panel
if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  if hash xfce4-taskmanager &> /dev/null; then
    INFO+="<click>xfce4-taskmanager</click>"
  fi
  INFO+="<txt>"
else
  INFO="<txt>"
fi
# Clock
if ((${CLOCK} <= 1000)); then
  INFO+="<span fgcolor='lightgreen'>${STDOUT}</span>"
elif ((${CLOCK} <= 2000)); then
  INFO+="<span fgcolor='yellow'>${STDOUT}</span>"
elif ((${CLOCK} <= 3000)); then
  INFO+="<span fgcolor='orange'>${STDOUT}</span>"
elif ((${CLOCK} <= 4000)); then
  INFO+="<span fgcolor='red'>${STDOUT}</span>"
else
  INFO+="${STDOUT}"
fi
# Temperature
if [ $(echo "${TEMP} <= 40.0" | bc -l) -eq 1 ]; then
  INFO+="<span fgcolor='lightgreen'> ${TEMP}°C</span>"
elif [ $(echo "${TEMP} <= 60.0" | bc -l) -eq 1 ]; then
  INFO+="<span fgcolor='yellow'> ${TEMP}°C</span>"
elif [ $(echo "${TEMP} <= 80.0" | bc -l) -eq 1 ]; then
  INFO+="<span fgcolor='orange'> ${TEMP}°C</span>"
elif [ $(echo "${TEMP} <= 100.0" | bc -l) -eq 1 ]; then
  INFO+="<span fgcolor='red'> ${TEMP}°C</span>"
else
  INFO+=" ${TEMP}°C"
fi

INFO+="</txt>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
