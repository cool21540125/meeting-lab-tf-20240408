#!/bin/env bash
# Usage: ./3-health-check.sh nginx

svc=$1

if [ "$svc" == "" ]; then
    echo "This script takes 1 argument: Service Name"
    echo "example:"
    echo "  ./3-health-check.sh nginx"
    exit 0
fi

for (( i=1; i<60; i=i+1 )); do
    curl --max-time 1 localhost:8080
    if [ "$?" == "0" ]; then
        echo "Service restarted successfully && check OK"
        exit 0
    else
        systemctl restart $svc

        sleep 10
        echo "This is $i time check failed, will retry again 10 secs later..."
    fi
done

echo "Service failed"
