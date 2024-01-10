#!/bin/bash

REDIS_PWD = 'opstergo1234'

# Prompt the user for confirmation
read -p "This will delete all data in the Redis database. Are you sure? (y/n): " confirm

# Check the user's response
if [ "$confirm" == "y" ]; then
    # Flush the Redis database
    kubectl exec -n redis redis-0 -- /usr/local/bin/redis-cli -a $REDIS_PWD "FLUSHDB"
    echo "Redis database flushed successfully."
else
    echo "Operation aborted."
fi