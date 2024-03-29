#!/usr/bin/env bash
set -e
# backup database
docker-compose exec -T mongodb sh -c 'mongodump --archive' > immersdb.dump

# update and restart
git pull
docker-compose pull
docker-compose up -d --remove-orphans
docker image prune -f
