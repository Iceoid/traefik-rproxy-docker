#!/bin/bash

# create an empty json for ssl certificate with the proper permissions
touch conf/acme.json
> conf/acme.json
chmod 600 conf/acme.json

# create a local environment variables file to pass to docker
touch .env
echo "# Domain name and cloudflare credentials" >> .env
echo "Enter the domain name to be used:"
read DOMAINNAME
echo "DOMAINNAME=${DOMAINNAME}" >> .env

echo "Enter a sub-domain name for the website:"
read SUBDOMAINNAME
echo "SUBDOMAINNAME=${SUBDOMAINNAME}" >> .env

echo "Enter your cloudflare email:"
read CF_EMAIL
echo "CF_API_EMAIL=${CF_EMAIL}" >> .env

echo "Enter your cloudflare Global API Key:"
read CF_API_KEY
echo "CF_API_KEY=${CF_API_KEY}" >> .env
chmod 640 .env

# create a user:hashed_password pair. This is for traefik basic authentication
touch .htpasswd
echo "installing dependencies...enter sudo password if necessary:"
sudo apt update -y && sudo apt install apache2-utils docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

echo "Enter a username:"
read USERNAME

echo "Enter a password:"
read -s PASSWORD

# TODO: verify password

echo $(htpasswd -nb ${USERNAME} ${PASSWORD}) >> .htpasswd
chmod 600 .htpasswd

# TODO: ask if user wants to copy website directory
read -r -p "Would you like to copy files in? [y/N] " response
if [[ "${response}" =~ ^([yY]|[yY][eE][sS])$ ]]; then
    echo "Enter dir path of files:"
    read dirPath
    cp -a ${dirPath}/. website/html/
fi


echo "Creating docker network: traefik_net"
docker network create traefik_net 

docker-compose up -d
docker ps

echo "Done!"
