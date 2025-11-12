#!/bin/bash

# Get an item from the DynamoDB table
# Usage: ./get-item.sh [user_id]

TABLE_NAME="demo-users"
USER_ID=${1:-"user-123"}

if [ -z "$1" ]; then
    echo "Usage: ./get-item.sh [user_id]"
    echo "Example: ./get-item.sh user-123"
    exit 1
fi

echo "Retrieving item from table: $TABLE_NAME"
echo "User ID: $USER_ID"
echo ""

aws dynamodb get-item \
    --table-name $TABLE_NAME \
    --key "{\"user_id\": {\"S\": \"$USER_ID\"}}" \
    --output json | jq '.'

if [ $? -ne 0 ]; then
    echo ""
    echo "Note: Install 'jq' for better JSON formatting, or use:"
    aws dynamodb get-item \
        --table-name $TABLE_NAME \
        --key "{\"user_id\": {\"S\": \"$USER_ID\"}}" \
        --output table
fi
