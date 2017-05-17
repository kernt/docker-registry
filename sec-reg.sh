#!/bin/bash

FILEOUT="/etc/docker/daemon.json"
EASTDN="example.com"
HOSTNAME="$(hostname -s)"
REG_DN="${HOSTNAME}${EASTDN}"
REG_PORT="5000"
DOCKER_REG_REPO_STOR="$(pwd)/docker/registry"

cattext() {
cat > ${FILEOUT} << EOF
{
"insecure-registries": ["$REG_DN:$REG_PORT"],
}
EOF
}

docker run -d -p 5000:5000 \
--name registry -v /:/docker/registry \
-e REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=\
/docker/registry registry

echo "show  current configuration: "
docker exec registry cat /etc/docker/registry/config.yml

