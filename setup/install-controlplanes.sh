#!/bin/bash
set -e

# Save the current working directory
ORIGINAL_DIR=$(pwd)

# Ensure we return to the original directory when the script exits
trap 'cd "$ORIGINAL_DIR"' EXIT

# Change to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Add Istio Helm repository
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

echo "Creating system namespaces..."
./namespaces/create-namespaces.sh

echo "Installing Istio base chart..."
helm install istio-base istio/base -n istio-system --create-namespace

echo "Installing Istio discovery chart for tenant-1..."
kubectl create ns tenant-1
kubectl label ns tenant-1 tenant-name=tenant-1
helm install istiod-tenant-1 istio/istiod \
  --namespace tenant-1 \
  --values values/tenant-1/values.yaml \
  --wait

echo "Installing Ingress Gateway for tenant-1..."
helm install gateway-tenant-1 istio/gateway \
  --namespace tenant-1 \
  --values values/tenant-1/gateway-values.yaml \
  --wait

kubectl apply -f manifests/tenant-1/peer-authentication.yaml
kubectl apply -f manifests/tenant-1/gateway.yaml
kubectl apply -f manifests/tenant-1/virtualservice.yaml

echo "Installing Istio discovery chart for tenant-2..."
kubectl create ns tenant-2
kubectl label ns tenant-2 tenant-name=tenant-2
helm install istiod-tenant-2 istio/istiod \
  --namespace tenant-2 \
  --values values/tenant-2/values.yaml \
  --wait

echo "Installing Ingress Gateway for tenant-2..."
helm install gateway-tenant-2 istio/gateway \
  --namespace tenant-2 \
  --values values/tenant-2/gateway-values.yaml \
  --wait

kubectl apply -f manifests/tenant-2/peer-authentication.yaml
kubectl apply -f manifests/tenant-2/gateway.yaml
kubectl apply -f manifests/tenant-2/virtualservice.yaml
