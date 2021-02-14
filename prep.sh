#!/bin/bash
touch conf/acme.json
> conf/acme.json
chmod 600 conf/acme.json

touch .env
"# Domain name and cloudflare credentials" >> .env
echo "Enter the domain name to be used:"
read DOMAINNAME
"DOMAINNAME=${DOMAINNAME}" >> .env
"CF_API_EMAIL=" >> .env
"CF_API_KEY=" >> .env

echo "You need to enter your cloudflare credentials in the .env file."

touch .htpasswd
sudo apt update -y && sudo apt install apache2-utils -y

echo "Enter a username:"
read USERNAME

echo "Enter a password:"
read PASSWORD

USER_HASHEDPWD=${htpasswd -nb $USERNAME $PASSWORD}
${USER_HASHEDPWD} >> .htpasswd
chmod 600 .htpasswd

echo "Done!"
