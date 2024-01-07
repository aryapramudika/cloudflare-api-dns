#!/bin/bash

# Cloudflare credentials and zone information
CF_API_KEY="YOUR_API_KEY"
CF_EMAIL="YOUR_EMAIL"
CF_ZONE_ID="YOUR_ZONE_ID"

# Input arguments for record name and type
RECORD_NAME=$1
RECORD_TYPE=$2

# Cloudflare API URL for fetching and deleting DNS records
CF_API_URL="https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records"

# Function to fetch the DNS record ID
fetch_record_id() {
    response=$(curl -s -X GET "$CF_API_URL?type=$RECORD_TYPE&name=$RECORD_NAME" \
     -H "Authorization: Bearer TR_iP6VWCd3QC7vtHDXQ4ypOhGZsQQVnj8R805NL" \
     -H "Content-Type: application/json")
    echo $(echo $response | grep -Po '"id":"\K[^"]+')
}

# Function to delete DNS record
delete_dns_record() {
    local record_id=$1
    curl -s -X DELETE "$CF_API_URL/$record_id" \
        -H "Authorization: Bearer TR_iP6VWCd3QC7vtHDXQ4ypOhGZsQQVnj8R805NL" \
        -H "Content-Type: application/json"
}

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <record name> <record type>"
    exit 1
fi

# Fetch and delete the DNS record
record_id=$(fetch_record_id)
if [ -z "$record_id" ]; then
    echo "Record not found."
    exit 1
fi

delete_dns_record $record_id
echo "Record deleted successfully."

