#!/usr/bin/env sh

set -e

command -v minikube 2>&1 || {
    echo "Could not find minikube on machine...";
    exit 1
}

minikube delete