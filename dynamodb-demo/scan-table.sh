#!/bin/bash

# Scan all items in the DynamoDB table
# Usage: ./scan-table.sh [limit]

TABLE_NAME="demo-users"
LIMIT=${1:-""}

echo "Scanning table: $TABLE_NAME"
if [ -n "$LIMIT" ]; then
    echo "Limit: $LIMIT items"
fi
echo ""

if [ -n "$LIMIT" ]; then
    aws dynamodb scan \
        --table-name $TABLE_NAME \
        --limit $LIMIT \
        --output json | jq '.'
else
    aws dynamodb scan \
        --table-name $TABLE_NAME \
        --output json | jq '.'
fi

if [ $? -ne 0 ]; then
    echo ""
    echo "Note: Install 'jq' for better JSON formatting, or use:"
    if [ -n "$LIMIT" ]; then
        aws dynamodb scan \
            --table-name $TABLE_NAME \
            --limit $LIMIT \
            --output table
    else
        aws dynamodb scan \
            --table-name $TABLE_NAME \
            --output table
    fi
fi
