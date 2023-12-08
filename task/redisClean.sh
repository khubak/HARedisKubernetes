#!/bin/bash

# Check if redis-cli is installed
command -v redis-cli >/dev/null 2>&1 || {
  echo >&2 "redis-cli is required but not installed. Aborting.";
  exit 1;
}

# Prompt the user for confirmation
read -p "This will delete all data in the Redis database. Are you sure? (y/n): " confirm

# add a line to connect to kubernetes

# Check the user's response
if [ "$confirm" == "y" ]; then
    # Flush the Redis database
    redis-cli FLUSHDB
    echo "Redis database flushed successfully."
else
    echo "Operation aborted."
fi