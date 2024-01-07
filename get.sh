#!/bin/bash

# Cloudflare credentials and zone information
CF_API_KEY="YOUR_API_KEY"
CF_EMAIL="YOUR_EMAIL"
CF_ZONE_ID="YOUR_ZONE_ID"

# Cloudflare API URL for DNS records
CF_API_URL="https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records"

# Function to get DNS records
get_dns_records() {
    curl -s -X GET $CF_API_URL \
        -H "Authorization: Bearer $CF_API_KEY" \
        -H "Content-Type: application/json"
}

# Fetch and display the DNS records
echo "Fetching DNS records..."
response=$(get_dns_records)
echo $response | jq -r '.result[] | "\(.name) \(.type) \(.content)"' | column -t -s ' '
