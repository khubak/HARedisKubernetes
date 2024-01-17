#!/bin/bash

set -e

# Read data from the file and import into Redis
if [ ! -f "data.txt" ]; then
    echo "Error: File 'data.txt' not found."
    exit 1
fi

while IFS= read -r line; do
    redis-cli -a passw0rd $line
done < "data.txt"

echo "Data imported to Redis successfully."

echo "Printing all Redis DB Keys with their respective values."

for i in $(redis-cli -a passw0rd KEYS '*'); do
    echo $i;
    redis-cli -a passw0rd GET $i;
done