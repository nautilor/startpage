#!/usr/bin/env bash

GC='\033[0;32m'
NC='\033[0m'

# remove old images if present
echo -e "${GC} Removing old images...${NC}"
docker stop startpage > /dev/null 2>&1
docker rm startpage > /dev/null 2>&1
docker rmi startpage:latest > /dev/null 2>&1

# build the new image
echo -e "${GC} Building new image...${NC}"
docker buildx build . -t startpage:latest --output=type=docker

# run the new image
echo -e "${GC} Running new image...${NC}"
docker run -d -p 127.0.0.1:9999:80 --name startpage startpage:latest

# set the image to always restart unless stopped
echo -e "${GC} Setting image to always restart...${NC}"
docker update --restart always startpage

echo -e "${GC} All done, your page is ready at localhost:9999${NC}"
