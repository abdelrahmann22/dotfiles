#!/bin/bash

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
mem_used=$(free -h | awk '/^Mem:/ {print $3}')
mem_total=$(free -h | awk '/^Mem:/ {print $2}')
mem_percent=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}')

echo "{\"text\": \"󰍛\", \"tooltip\": \"CPU: ${cpu}%\nRAM: ${mem_used} / ${mem_total} (${mem_percent}%)\"}"



