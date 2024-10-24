#!/bin/bash
set -e

# Get gateway IPs
GATEWAY1_CLUSTER_IP=$(kubectl -n tenant-1 get service gateway-tenant-1 -o jsonpath="{.spec.clusterIP}")
GATEWAY2_CLUSTER_IP=$(kubectl -n tenant-2 get service gateway-tenant-2 -o jsonpath="{.spec.clusterIP}")

echo "🧪Testing httpbin1 ingress access..."
cmd="kubectl -n app-ns-1 exec \"\$(kubectl -n app-ns-1 get pod -l app=sleep -o jsonpath={.items..metadata.name})\" -c sleep -- \
  curl -I -H \"Host: httpbin1.example.com\" http://\${GATEWAY1_CLUSTER_IP}/"
echo $cmd
response=$(eval $cmd)
if [[ "$response" == *"HTTP/1.1 200 OK"* ]]; then
  echo "✅Success"
else
  echo "❌Failed"
fi


echo
echo "🧪Testing httpbin2 ingress access..."
cmd="kubectl -n app-ns-1 exec \"\$(kubectl -n app-ns-1 get pod -l app=sleep -o jsonpath={.items..metadata.name})\" -c sleep -- \
  curl -I -H \"Host: httpbin2.example.com\" http://\${GATEWAY2_CLUSTER_IP}/"
echo $cmd
response=$(eval $cmd)
if [[ "$response" == *"HTTP/1.1 200 OK"* ]]; then
  echo "✅Success"
else
  echo "❌Failed"
fi
