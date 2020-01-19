#!/bin/bash

# Colors.
NC='\033[0m' # No Color
LIGHT_GREEN='\033[1;32m'

echo -e "${LIGHT_GREEN}Generate certificate for '*.docker.localhost'.${NC}"
mkcert -cert-file ./certs/_wildcard.docker.localhost.pem -key-file ./certs/_wildcard.docker.localhost-key.pem "*.docker.localhost"

