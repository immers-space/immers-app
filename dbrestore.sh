#!/bin/sh
docker-compose exec -T mongodb sh -c 'mongorestore --archive' < immersdb.dump
