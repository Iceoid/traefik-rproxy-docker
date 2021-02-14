#!/bin/bash

# TODO: add an optional 2nd subdomain registration for the website (possibly only the domain name)

echo "installing dependencies...enter sudo password if necessary:"
sudo apt update -y && sudo apt install apache2-utils docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

read -rp "Would you like to cleanup before install? [y/N] " cleanupResponse
if [[ "${cleanupResponse}" =~ ^([yY]|[yY][eE][sS])$ ]]; then
    echo "Starting cleanup!"$'\n'
    bash cleanup.sh
fi

read -rp "Would you like initialise the sensitive files? [y/N] " initResponse
if [[ "${initResponse}" =~ ^([yY]|[yY][eE][sS])$ ]]; then

    # create an empty json for ssl certificate with the proper permissions
    touch conf/acme.json
    > conf/acme.json
    chmod 600 conf/acme.json

    # create a local environment variables file to pass to docker
    touch .env
    > .env

    echo "# Domain name and cloudflare credentials" >> .env

    read -rp "Enter the domain name to be used:"$'\n' DOMAINNAME
    echo "DOMAINNAME=${DOMAINNAME}" >> .env

    read -rp "Enter a sub-domain name for the website:"$'\n' SUBDOMAINNAME
    echo "SUBDOMAINNAME=${SUBDOMAINNAME}" >> .env

    read -rp "Enter your cloudflare email:"$'\n' CF_EMAIL
    echo "CF_API_EMAIL=${CF_EMAIL}" >> .env

    read -rp "Enter your cloudflare Global API Key:"$'\n' CF_API_KEY
    echo "CF_API_KEY=${CF_API_KEY}" >> .env

    chmod 640 .env

    # create a user:hashed_password pair. This is for traefik basic authentication
    touch .htpasswd
    > .htpasswd

    read -rp "Enter a username:"$'\n' USERNAME

    PASSWD_WRONG=true
    while [[ "$PASSWD_WRONG"=true ]]; do
        read -srp "Enter a password:"$'\n' PASSWORD
        read -srp "Re-enter your password:"$'\n' PASSCHECK
        if [[ "$PASSWORD" == "$PASSCHECK" ]]; then
            break
        fi
        echo "Your passwords do not match!"$'\n'
    done

    echo $(htpasswd -nb ${USERNAME} ${PASSWORD}) >> .htpasswd
    chmod 600 .htpasswd
fi

# Ask if user wants to copy website files
read -rp "Would you like to copy files in? (This will delete all files in website/html.) [y/N] " response
if [[ "${response}" =~ ^([yY]|[yY][eE][sS])$ ]]; then
    echo "Enter dir path of files:"
    read dirPath
    rm -Rf website/html/*
    cp -a ${dirPath}/. website/html/
fi

echo "Creating docker network: traefik_net"
docker network create traefik_net

docker-compose up -d
docker ps

echo "Done!"