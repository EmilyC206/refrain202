#!/bin/bash

# Delete an item from the DynamoDB table
# Usage: ./delete-item.sh [user_id]

TABLE_NAME="demo-users"
USER_ID=${1:-""}

if [ -z "$USER_ID" ]; then
    echo "Usage: ./delete-item.sh [user_id]"
    echo "Example: ./delete-item.sh user-123"
    exit 1
fi

echo "Deleting item from table: $TABLE_NAME"
echo "User ID: $USER_ID"
echo ""
echo "Are you sure you want to delete this item? (y/N)"
read -r confirmation

if [ "$confirmation" != "y" ] && [ "$confirmation" != "Y" ]; then
    echo "Deletion cancelled."
    exit 0
fi

aws dynamodb delete-item \
    --table-name $TABLE_NAME \
    --key "{\"user_id\": {\"S\": \"$USER_ID\"}}" \
    --return-values ALL_OLD \
    --output json | jq '.'

if [ $? -eq 0 ]; then
    echo ""
    echo "Item deleted successfully!"
else
    echo "Error deleting item."
fi
