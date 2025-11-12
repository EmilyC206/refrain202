#!/bin/bash

# Query items from the DynamoDB table
# Usage: ./query-table.sh [user_id]

TABLE_NAME="demo-users"
USER_ID=${1:-""}

if [ -z "$USER_ID" ]; then
    echo "Usage: ./query-table.sh [user_id]"
    echo "Example: ./query-table.sh user-123"
    exit 1
fi

echo "Querying table: $TABLE_NAME"
echo "User ID: $USER_ID"
echo ""

aws dynamodb query \
    --table-name $TABLE_NAME \
    --key-condition-expression "user_id = :uid" \
    --expression-attribute-values "{\":uid\": {\"S\": \"$USER_ID\"}}" \
    --output json | jq '.'

if [ $? -ne 0 ]; then
    echo ""
    echo "Note: Install 'jq' for better JSON formatting, or use:"
    aws dynamodb query \
        --table-name $TABLE_NAME \
        --key-condition-expression "user_id = :uid" \
        --expression-attribute-values "{\":uid\": {\"S\": \"$USER_ID\"}}" \
        --output table
fi
