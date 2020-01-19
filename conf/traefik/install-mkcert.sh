#!/bin/bash

MKCERT_VERSION='v1.4.1'

# Colors.
NC='\033[0m' # No Color
LIGHT_GREEN='\033[1;32m'

echo -e "${LIGHT_GREEN}Update apt repositories.${NC}"
sudo apt-get update

echo -e "${LIGHT_GREEN}Install required dependencies.${NC}"
sudo apt install wget libnss3-tools

echo -e "${LIGHT_GREEN}Download mkcert version ${MKCERT_VERSION}.${NC}"
wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/${MKCERT_VERSION}/mkcert-${MKCERT_VERSION}-linux-amd64

echo -e "${LIGHT_GREEN}Make mkcert executable.${NC}"
chmod +x  mkcert

echo -e "${LIGHT_GREEN}Move mkcert into /usr/local/bin.${NC}"
sudo mv mkcert /usr/local/bin

echo -e "${LIGHT_GREEN}Install certificate authority to avoid validation error.${NC}"
mkcert -install
