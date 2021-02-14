#!/bin/bash
docker stop traefik traefik_website
docker rm traefik traefik_website
docker network rm traefik_net

rm -fR -i website/html/*

rm -f -i .env
rm -f -i .htpasswd
rm -f -i conf/acme.json