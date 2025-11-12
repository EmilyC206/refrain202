#!/bin/bash

# Delete the DynamoDB table
# Usage: ./delete-table.sh [table-name]

TABLE_NAME=${1:-"demo-users"}

echo "WARNING: This will delete the table: $TABLE_NAME"
echo "All data in this table will be permanently lost!"
echo ""
echo "Are you sure you want to delete this table? (y/N)"
read -r confirmation

if [ "$confirmation" != "y" ] && [ "$confirmation" != "Y" ]; then
    echo "Deletion cancelled."
    exit 0
fi

echo "Deleting table: $TABLE_NAME"

aws dynamodb delete-table \
    --table-name $TABLE_NAME

if [ $? -eq 0 ]; then
    echo "Table deletion initiated!"
    echo "Waiting for table to be deleted..."
    aws dynamodb wait table-not-exists --table-name $TABLE_NAME
    echo "Table has been deleted!"
else
    echo "Error deleting table. It may not exist."
fi
