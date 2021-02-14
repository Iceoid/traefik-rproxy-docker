#!/bin/bash
sudo docker stop traefik traefik_website
sudo docker rm traefik traefik_website
sudo docker network rm traefik_net

rm -f .env
rm -f .htpasswd
rm -f -i conf/acme.conf