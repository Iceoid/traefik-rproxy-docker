#!/bin/bash
touch conf/acme.json
> conf/acme.json
chmod 600 conf/acme.json

touch .env
echo "# Domain name and cloudflare credentials" >> .env
echo "Enter the domain name to be used:"
read DOMAINNAME
echo "DOMAINNAME=${DOMAINNAME}" >> .env
echo "CF_API_EMAIL=" >> .env
echo "CF_API_KEY=" >> .env

touch .htpasswd
echo "executing apt update && apt install apache2-utils...enter sudo password:"
sudo apt update -y && sudo apt install apache2-utils -y

echo "Enter a username:"
read USERNAME

echo "Enter a password:"
read PASSWORD

USER_HASHEDPWD=$(htpasswd -nb ${USERNAME} ${PASSWORD})
echo "${USER_HASHEDPWD}" >> .htpasswd
chmod 600 .htpasswd

echo "Done!"
echo "You still need to enter your cloudflare credentials in the .env file."
