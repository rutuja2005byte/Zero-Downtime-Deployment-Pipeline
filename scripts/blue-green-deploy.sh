#!/bin/bash

set -e

echo "Starting Blue-Green Deployment..."

echo "Checking Blue health..."
curl -f http://localhost:3001/health
echo

echo "Checking Green health..."
curl -f http://localhost:3002/health
echo

echo "Both environments are healthy."

echo "Testing Green version..."
curl http://localhost:3002/version
echo

echo "Switching traffic to Green..."

sed 's/proxy_pass http:\/\/blue;/proxy_pass http:\/\/green;/' nginx.conf > nginx.conf.tmp
cat nginx.conf.tmp > nginx.conf
rm nginx.conf.tmp

echo "Testing NGINX configuration..."
docker exec nginx nginx -t

echo "Reloading NGINX..."
docker exec nginx nginx -s reload

echo "Deployment completed."

echo "Current production version:"
curl http://localhost/version
echo