#!/bin/bash

# Check if the file exists
if [ ! -f "./import/redis_data.txt" ]; then
    echo "Error: File 'redis_data.txt' not found."
    exit 1
fi

# Read data from the file and import into Redis
# add a line to connect to kubernetes
while IFS= read -r line; do
    redis-cli $line
done < "redis_data.txt"

echo "Data imported to Redis successfully."