#!/bin/bash

# Describe a DynamoDB table
# Usage: ./describe-table.sh [table-name]

TABLE_NAME=${1:-"demo-users"}

echo "Describing table: $TABLE_NAME"
echo ""

aws dynamodb describe-table \
    --table-name $TABLE_NAME \
    --output json | jq '.'

# If jq is not available, use table format
if [ $? -ne 0 ]; then
    echo "Note: Install 'jq' for better JSON formatting, or use:"
    echo "aws dynamodb describe-table --table-name $TABLE_NAME --output table"
    aws dynamodb describe-table --table-name $TABLE_NAME --output table
fi
