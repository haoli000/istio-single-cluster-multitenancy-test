#!/bin/bash
set -e

kubectl label ns app-ns-1 tenant-name=tenant-1 istio.io/rev=tenant-1
kubectl label ns app-ns-2 tenant-name=tenant-2 istio.io/rev=tenant-2
kubectl label ns app-ns-3 tenant-name=tenant-2 istio.io/rev=tenant-2
