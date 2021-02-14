##### Simple auto cert reverse proxy for a static web page
### You can run the prep.sh script to initialize the files needed.
### Copy the website's files in the website/html folder.

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