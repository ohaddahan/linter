#!/bin/sh
docker stop $(docker ps | \grep ohaddahan/linter:latest | awk '{print $1}')
docker build -t ohaddahan/linter:latest .
docker run -d -p 3000:3000 ohaddahan/linter:latest
