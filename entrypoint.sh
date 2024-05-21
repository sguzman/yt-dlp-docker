#!/bin/sh

# Run Newsboat reload in an infinite loop with a sleep interval
while true; do
    newsboat --log-level 5 --log-file /dev/stdout -x reload
    sleep 300
done

