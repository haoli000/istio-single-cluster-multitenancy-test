#!/bin/bash
set -e

echo "🧪Testing cross-tenany connectivity (1->2 should fail)..."
cmd="kubectl -n app-ns-1 exec \"\$(kubectl -n app-ns-1 get pod -l app=sleep -o jsonpath={.items..metadata.name})\" \
  -c sleep -- curl -sIL http://httpbin.app-ns-2.svc.cluster.local:8000"
echo $cmd
response=$(eval $cmd)
if [[ "$response" == *"HTTP/1.1 503 Service Unavailable"* ]]; then
  echo "✅Failed"
else
  echo "❌Success"
fi

echo
echo "🧪Testing cross-tenany connectivity (2->1 should fail)..."
cmd="kubectl -n app-ns-2 exec \"\$(kubectl -n app-ns-2 get pod -l app=sleep -o jsonpath={.items..metadata.name})\" \
  -c sleep -- curl -sIL http://httpbin.app-ns-1.svc.cluster.local:8000"
echo $cmd
response=$(eval $cmd)
if [[ "$response" == *"HTTP/1.1 503 Service Unavailable"* ]]; then
  echo "✅Failed"
else
  echo "❌Success"
fi

echo
echo "🧪Testing intra-tenancy connectivity (2->3 should succeed)..."
cmd="kubectl -n app-ns-2 exec \"\$(kubectl -n app-ns-2 get pod -l app=sleep -o jsonpath={.items..metadata.name})\" \
  -c sleep -- curl -sIL http://httpbin.app-ns-3.svc.cluster.local:8000"
echo $cmd
response=$(eval $cmd)
if [[ "$response" == *"HTTP/1.1 200 OK"* ]]; then
  echo "✅️Success"
else
  echo "❌Failed"
fi
