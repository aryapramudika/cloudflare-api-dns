# Cloudflare API DNS Script
Cloudflare Update DNS Record using API Script

You can use for automation edit DNS Record using script.

## How to use

Clone this repository, you can move this script file to /usr/local/bin or directly run.

Give execute permission

```
cd cloudflare-api-dns
chmod +x *
```

Change the credentials (API_KEY, EMAIL, ZONE_ID)

Reference to get this credentials:

* https://developers.cloudflare.com/fundamentals/api/get-started/create-token/
* https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/


### Get Record

```
Usage: ./get.sh

cod.example.com              A      xx.xx.xx.xx
jenkins.example.com          A      xx.xx.xx.xx
jitsi.example.com            A      xx.xx.xx.xx
example.com                  A      xx.xx.xx.xx
```
### Add Record

```
Usage: ./add.sh <subdomain> <record type> <record content> <proxied> <TTL>

./add.sh test CNAME test.aryapramudika.com false 3600
```

### Delete Record

For using this delete script, make sure you have installed jsontools / jq in Linux
```
Usage: ./delete.sh <record name> <record type>

./delete.sh test CNAME
```
