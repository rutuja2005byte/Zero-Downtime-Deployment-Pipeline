#!/bin/bash

set -e

echo "Starting rollback..."

echo "Switching traffic back to Blue..."

sed 's/proxy_pass http:\/\/green;/proxy_pass http:\/\/blue;/' nginx.conf > nginx.conf.tmp
cat nginx.conf.tmp > nginx.conf
rm nginx.conf.tmp

echo "Testing NGINX configuration..."

docker exec nginx nginx -t

echo "Reloading NGINX..."

docker exec nginx nginx -s reload

echo "Rollback completed successfully."

echo "Current production version:"
curl http://localhost/version
echo