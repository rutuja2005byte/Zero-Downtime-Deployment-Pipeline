#!/bin/bash

set -e

echo "Starting rollback..."

echo "Switching traffic back to Blue..."

sed -i '' 's/proxy_pass http:\/\/green;/proxy_pass http:\/\/blue;/' nginx.conf

echo "Testing NGINX configuration..."

docker exec nginx nginx -t

echo "Reloading NGINX..."

docker exec nginx nginx -s reload

echo "Rollback completed successfully."

echo "Current production version:"

curl http://localhost/version