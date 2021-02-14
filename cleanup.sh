#!/bin/bash
sudo docker stop traefik traefik_website
sudo docker rm traefik traefik_website
sudo docker network rm traefik_net

rm -fR -i website/html/.

rm -f -i .env
rm -f -i .htpasswd
rm -f -i conf/acme.conf