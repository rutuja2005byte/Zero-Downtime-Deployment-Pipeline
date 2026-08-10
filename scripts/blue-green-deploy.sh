#!/bin/bash

set -e

echo "Starting Blue-Green Deployment..."

echo "Checking Blue health..."
curl -f http://localhost:3001/health

echo "Checking Green health..."
curl -f http://localhost:3002/health

echo "Both environments are healthy."

echo "Testing Green version..."
curl http://localhost:3002/version

echo "Switching traffic to Green..."

sed -i '' 's/proxy_pass http:\/\/blue;/proxy_pass http:\/\/green;/' nginx.conf

echo "Testing NGINX configuration..."
docker exec nginx nginx -t

echo "Reloading NGINX..."
docker exec nginx nginx -s reload

echo "Deployment completed."

echo "Current production version:"
curl http://localhost/version