#!/bin/bash
set -euxo pipefail

dnf install -y docker
systemctl enable docker
systemctl start docker

# Pull and run the containerised page. 
docker pull ${container_image}
docker run -d \
  --name web \
  --restart unless-stopped \
  -p 80:80 \
  ${container_image}
