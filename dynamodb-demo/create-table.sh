#!/bin/bash

# Create a DynamoDB table for the demo
# This script creates a table called 'demo-users' with a simple schema

TABLE_NAME="demo-users"

echo "Creating DynamoDB table: $TABLE_NAME"

aws dynamodb create-table \
    --table-name $TABLE_NAME \
    --attribute-definitions \
        AttributeName=user_id,AttributeType=S \
    --key-schema \
        AttributeName=user_id,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --tags Key=Project,Value=DynamoDB-Demo Key=Environment,Value=Demo

if [ $? -eq 0 ]; then
    echo "Table creation initiated successfully!"
    echo "Waiting for table to become active..."
    aws dynamodb wait table-exists --table-name $TABLE_NAME
    echo "Table is now active!"
else
    echo "Error creating table. It may already exist."
    echo "To check existing tables, run: aws dynamodb list-tables"
fi
