#!/bin/bash

SERVICES=("mysql")

if [[ "$1" == "discover" ]]; then
    echo -n '{"data":['
    for i in "${!SERVICES[@]}"; do
        if [[ $i -gt 0 ]]; then echo -n ','; fi
        echo -n '{"{#SERVICE_NAME}":"'${SERVICES[$i]^^}'"}'
    done
    echo -n ']}'
elif [[ "$1" == "status" && -n "$2" ]]; then
    SERVICE_NAME_LOWER=$(echo "$2" | tr '[:upper:]' '[:lower:]')
    systemctl is-active "$SERVICE_NAME_LOWER" >/dev/null 2>&1 && echo 1 || echo 0
else
    echo "Usage: $0 discover | status <service_name>"
    exit 1
fi
# to be trankhai
