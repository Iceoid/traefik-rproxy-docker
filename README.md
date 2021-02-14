# Simple auto-cert reverse proxy for a static web page.

## Run the install.sh script to get everything in order.

## For manual install:
### Prerequisites:
    - Having docker and docker-compose installed.
    - Have a domain name, pointing to the IP address of the machine you are installing this on.
    - Have your domain's nameservers on cloudflare (we are using dns-cloudflare module to get SSL certificates).

### 1. Create a .env file and have those 3 environment variables filled in. (at the root of the project, with 0600 permissions)

DOMAINNAME= <br />
CF_API_EMAIL= <br />
CF_API_KEY= <br />

### 2. Add a .htpasswd file to the root of the project. (with 0640 permissions)
#### to get a .htpasswd formated password: get the apt package 'apache2-utils' and use (replace *username* and *password*):
`echo $(htpasswd -nb username password) >> .htpasswd`

### 3. Create empty acme.json at conf/acme.json with permissions 0600

```
touch traefik/conf/acme.json \
> conf/acme.json \
chmod 600 conf/acme.json \
```

### 4. Copy the website's files in the website/html folder.
