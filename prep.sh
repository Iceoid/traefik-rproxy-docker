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
echo "executing apt update && apt install apache2-utils...enter sudo password if necessary:"
sudo apt update -y && sudo apt install apache2-utils -y

echo "Enter a username:"
read USERNAME

echo "Enter a password:"
read -s PASSWORD

echo $(htpasswd -nb ${USERNAME} ${PASSWORD}) >> .htpasswd
chmod 600 .htpasswd

echo "Done!"
echo "You still need to enter your cloudflare credentials in the .env file."
