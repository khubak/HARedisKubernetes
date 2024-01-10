#!/bin/bash

# Check if the file exists
if [ ! -f "import/redis/data.txt" ]; then
    echo "Error: File 'data.txt' not found."
    exit 1
fi

kubectl cp import/redis/data.txt redis/redis-0:/data
kubectl cp redisImport-01.sh redis/redis-0:/data
kubectl exec -n redis redis-0 -- /bin/sh redisImport-01.sh