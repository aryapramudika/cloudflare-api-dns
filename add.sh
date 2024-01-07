#!/bin/bash

# Cloudflare credentials and zone information
CF_API_KEY="YOUR_API_KEY"
CF_EMAIL="YOUR_EMAIL"
CF_ZONE_ID="YOUR_ZONE_ID"

# Input arguments
SUBDOMAIN_NAME=$1
RECORD_TYPE=$2
RECORD_CONTENT=$3
PROXIED=$4  # true or false
TTL=$5      # Time to live for the record

# Cloudflare API URL
CF_API_URL="https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records"

# Function to add DNS record
# Function to add DNS record
add_dns_record() {
    response=$(curl -s -X POST $CF_API_URL \
        -H "Authorization: Bearer $CF_API_KEY" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"$RECORD_TYPE\",\"name\":\"$SUBDOMAIN_NAME\",\"content\":\"$RECORD_CONTENT\",\"proxied\":$PROXIED, \"ttl\":$TTL}")

    # Check if the operation was successful
    echo $response | jq -e '.success' > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Record added successfully. Details:"
        echo -e "Name\tType\tContent\tProxied\tTTL"
        echo $response | jq -r '"\(.result.name) \(.result.type) \(.result.content) \(.result.proxied) \(.result.ttl)"' | column -t -s ' '
    else
        echo "Failed to add record. Response from Cloudflare:"
        echo $response | jq '.errors'
    fi
}

# Check for correct number of arguments
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <subdomain> <record type> <record content> <proxied> <TTL>"
    exit 1
fi
# Add the DNS record
add_dns_record

