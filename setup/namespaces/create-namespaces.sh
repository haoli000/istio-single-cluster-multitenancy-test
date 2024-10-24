#!/bin/bash
set -e

# Save the current working directory
ORIGINAL_DIR=$(pwd)

# Ensure we return to the original directory when the script exits
trap 'cd "$ORIGINAL_DIR"' EXIT

# Change to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Creating application namespaces..."
kubectl create ns app-ns-1
kubectl create ns app-ns-2
kubectl create ns app-ns-3

echo "Applying namespace labels..."
./namespace-labels.sh
