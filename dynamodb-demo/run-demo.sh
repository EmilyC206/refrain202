#!/bin/bash

# Complete demo script that runs through all DynamoDB operations
# This script demonstrates a full workflow

TABLE_NAME="demo-users"
DEMO_USER_ID="demo-user-$(date +%s)"

echo "========================================="
echo "AWS CLI DynamoDB Demo"
echo "========================================="
echo ""

# Check if AWS CLI is configured
echo "Checking AWS CLI configuration..."
aws sts get-caller-identity > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: AWS CLI is not configured!"
    echo "Please run 'aws configure' first or set AWS credentials."
    exit 1
fi
echo "✓ AWS CLI is configured"
echo ""

# Step 1: Create table
echo "Step 1: Creating table '$TABLE_NAME'..."
./create-table.sh > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✓ Table created successfully"
else
    echo "⚠ Table may already exist, continuing..."
fi
echo ""

# Step 2: List tables
echo "Step 2: Listing all tables..."
./list-tables.sh
echo ""

# Step 3: Add items
echo "Step 3: Adding demo items..."
./put-item.sh "$DEMO_USER_ID" "Alice Smith" "alice@example.com" "28" "Seattle"
./put-item.sh "user-001" "Bob Johnson" "bob@example.com" "35" "Chicago"
./put-item.sh "user-002" "Carol Williams" "carol@example.com" "42" "Boston"
echo "✓ Added 3 items"
echo ""

# Step 4: Get item
echo "Step 4: Retrieving item..."
./get-item.sh "$DEMO_USER_ID"
echo ""

# Step 5: Query table
echo "Step 5: Querying table..."
./query-table.sh "$DEMO_USER_ID"
echo ""

# Step 6: Scan table
echo "Step 6: Scanning table (first 5 items)..."
./scan-table.sh 5
echo ""

# Step 7: Update item
echo "Step 7: Updating item..."
./update-item.sh "$DEMO_USER_ID" "age" "29" "N"
echo ""

# Step 8: Describe table
echo "Step 8: Describing table..."
./describe-table.sh "$TABLE_NAME"
echo ""

echo "========================================="
echo "Demo completed!"
echo "========================================="
echo ""
echo "To clean up, you can:"
echo "  1. Delete items: ./delete-item.sh $DEMO_USER_ID"
echo "  2. Delete table: ./delete-table.sh $TABLE_NAME"
echo ""
