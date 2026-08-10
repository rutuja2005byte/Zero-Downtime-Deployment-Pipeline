#!/bin/bash

set -e

echo "Starting Rolling Update..."

echo "Current versions:"
curl -s http://localhost:4001/version
curl -s http://localhost:4002/version
curl -s http://localhost:4003/version

echo ""
echo "Updating app-1..."

docker compose -f docker-compose.rolling.yml stop app-1
docker compose -f docker-compose.rolling.yml rm -f app-1

docker compose -f docker-compose.rolling.yml up -d --build app-1

echo "Waiting for app-1 to become healthy..."
sleep 10

curl -f http://localhost:4001/health

echo "app-1 updated successfully."

echo "Updating app-2..."

docker compose -f docker-compose.rolling.yml stop app-2
docker compose -f docker-compose.rolling.yml rm -f app-2

docker compose -f docker-compose.rolling.yml up -d --build app-2

echo "Waiting for app-2 to become healthy..."
sleep 10

curl -f http://localhost:4002/health

echo "app-2 updated successfully."

echo "Updating app-3..."

docker compose -f docker-compose.rolling.yml stop app-3
docker compose -f docker-compose.rolling.yml rm -f app-3

docker compose -f docker-compose.rolling.yml up -d --build app-3

echo "Waiting for app-3 to become healthy..."
sleep 10

curl -f http://localhost:4003/health

echo "app-3 updated successfully."

echo ""
echo "Rolling Update Completed!"

echo "Final versions:"
curl -s http://localhost:4001/version
curl -s http://localhost:4002/version
curl -s http://localhost:4003/version