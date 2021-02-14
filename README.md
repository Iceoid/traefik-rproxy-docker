##### Simple auto cert reverse proxy
### You can run the prep.sh script to initialize the files needed.
### Need to add a .env file at the root directory of the project (same level as the docker-compose) with the following environnement variables:

DOMAINNAME= 
CF_API_EMAIL= 
CF_API_KEY= 

### Need to add a .htpasswd file to the root of the project.
### to get a .htpasswd formated password: get the apt package 'apache2-utils' and use:
$ htpasswd -nb username password
### then copy output in the .htpasswd file:
user:hashedpasswd

### Create empty acme.json at traefik/conf/acme.json with permissions 0600
$ touch traefik/conf/acme.json
$ echo "" > traefik/conf/acme.json
$ chmod 600 traefik/conf/acme.json