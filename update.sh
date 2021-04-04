#!/bin/sh

# backup database
docker-compose exec -T mongodb sh -c 'mongodump --archive' > immersdb.dump

# update and restart
docker-compose pull
docker-compose up -d --remove-orphans
docker image prune
