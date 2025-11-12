#!/bin/bash

# Put an item into the DynamoDB table
# Usage: ./put-item.sh [user_id] [name] [email] [age] [city]

TABLE_NAME="demo-users"
USER_ID=${1:-"user-$(date +%s)"}
NAME=${2:-"John Doe"}
EMAIL=${3:-"john.doe@example.com"}
AGE=${4:-"30"}
CITY=${5:-"New York"}

echo "Adding item to table: $TABLE_NAME"
echo "User ID: $USER_ID"
echo "Name: $NAME"
echo "Email: $EMAIL"
echo "Age: $AGE"
echo "City: $CITY"
echo ""

aws dynamodb put-item \
    --table-name $TABLE_NAME \
    --item "{
        \"user_id\": {\"S\": \"$USER_ID\"},
        \"name\": {\"S\": \"$NAME\"},
        \"email\": {\"S\": \"$EMAIL\"},
        \"age\": {\"N\": \"$AGE\"},
        \"city\": {\"S\": \"$CITY\"}
    }" \
    --return-consumed-capacity TOTAL

if [ $? -eq 0 ]; then
    echo ""
    echo "Item added successfully!"
    echo "To retrieve this item, run: ./get-item.sh $USER_ID"
else
    echo "Error adding item. Make sure the table exists."
fi
