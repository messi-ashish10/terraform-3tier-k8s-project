#!/bin/bash
set -e

yum update -y

amazon-linux-extras install docker -y

systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

sleep 10

docker pull ashishgurau/backend:v6

docker run -d \
    --name backend \
    -p 8080:5000 \
    --restart always \
    ashishgurau/backend:v6