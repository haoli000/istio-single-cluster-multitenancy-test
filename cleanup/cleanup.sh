#!/bin/bash

echo "Cleaning up tenant-1..."
helm uninstall gateway-tenant-1 -n tenant-1
helm uninstall istiod-tenant-1 -n tenant-1
kubectl delete ns app-ns-1 tenant-1

echo "Cleaning up tenant-2..."
helm uninstall gateway-tenant-2 -n tenant-2
helm uninstall istiod-tenant-2 -n tenant-2
kubectl delete ns app-ns-2 app-ns-3 tenant-2

echo "Cleaning up Istio base..."
helm uninstall istio-base -n istio-system
kubectl delete ns istio-system
