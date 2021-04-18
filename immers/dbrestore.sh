#!/usr/bin/env bash
docker-compose exec -T mongodb sh -c 'mongorestore --archive' < immersdb.dump
