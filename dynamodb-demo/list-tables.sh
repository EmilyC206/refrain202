#!/bin/bash

# List all DynamoDB tables in your account

echo "Listing all DynamoDB tables..."

aws dynamodb list-tables --output table

echo ""
echo "To get more details about a specific table, use describe-table.sh"
