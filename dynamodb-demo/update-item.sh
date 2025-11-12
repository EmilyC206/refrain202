#!/bin/bash

# Update an item in the DynamoDB table
# Usage: ./update-item.sh [user_id] [attribute] [value] [type]
# Example: ./update-item.sh user-123 age 31 N
# Example: ./update-item.sh user-123 city "San Francisco" S

TABLE_NAME="demo-users"
USER_ID=${1:-""}
ATTRIBUTE=${2:-""}
VALUE=${3:-""}
TYPE=${4:-"S"}

if [ -z "$USER_ID" ] || [ -z "$ATTRIBUTE" ] || [ -z "$VALUE" ]; then
    echo "Usage: ./update-item.sh [user_id] [attribute] [value] [type]"
    echo "  type: S (String), N (Number), SS (String Set), NS (Number Set)"
    echo "Example: ./update-item.sh user-123 age 31 N"
    echo "Example: ./update-item.sh user-123 city \"San Francisco\" S"
    exit 1
fi

echo "Updating item in table: $TABLE_NAME"
echo "User ID: $USER_ID"
echo "Attribute: $ATTRIBUTE"
echo "Value: $VALUE"
echo "Type: $TYPE"
echo ""

# Format the value based on type
if [ "$TYPE" = "N" ]; then
    VALUE_JSON="{\"$TYPE\": \"$VALUE\"}"
else
    VALUE_JSON="{\"$TYPE\": \"$VALUE\"}"
fi

aws dynamodb update-item \
    --table-name $TABLE_NAME \
    --key "{\"user_id\": {\"S\": \"$USER_ID\"}}" \
    --update-expression "SET $ATTRIBUTE = :val" \
    --expression-attribute-values "{\":val\": $VALUE_JSON}" \
    --return-values ALL_NEW \
    --output json | jq '.'

if [ $? -eq 0 ]; then
    echo ""
    echo "Item updated successfully!"
else
    echo "Error updating item."
fi
