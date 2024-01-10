#!/bin/bash

REDIS_PWD = 'opstergo1234'

# Read data from the file and import into Redis
if [ ! -f "data.txt" ]; then
    echo "Error: File 'data.txt' not found."
    exit 1
fi

while IFS= read -r line; do
    redis-cli -a $REDIS_PWD $line
done < "data.txt"

echo "Data imported to Redis successfully."

echo "Printing all Redis DB Keys with their respective values."

for i in $(redis-cli -a opstergo1234 KEYS '*'); do
    echo $i;
    redis-cli -a opstergo1234 GET $i;
done