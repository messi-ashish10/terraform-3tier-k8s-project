#!/bin/bash
set -e

LOG=/var/log/user-data.log
exec > >(tee -a $LOG) 2>&1

echo "=== User data started ==="

# Clean and refresh yum safely
yum clean all
yum makecache fast

# Install Docker with retries (critical)
for i in {1..10}; do
  yum install -y docker && break
  echo "Docker install failed, retrying in 15s..."
  sleep 15
done

# Start Docker
systemctl daemon-reload
systemctl start docker
systemctl enable docker

# Allow ec2-user to use docker later
usermod -aG docker ec2-user

# Wait for Docker daemon to be ready
until docker info >/dev/null 2>&1; do
  echo "Waiting for Docker to start..."
  sleep 5
done

# Pull and run backend
docker pull ashishgurau/backend:v7

docker rm -f backend || true

docker run -d \
  --name backend \
  -p 8080:5000 \
  --restart always \
  -e MONGO_URL="" \
  ashishgurau/backend:v8

echo "=== User data finished successfully ==="
