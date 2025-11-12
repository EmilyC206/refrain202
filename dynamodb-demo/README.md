# AWS CLI DynamoDB Demo

This demo demonstrates how to use AWS CLI to interact with Amazon DynamoDB.

## Prerequisites

- AWS CLI installed (already installed in this environment)
- AWS account with appropriate permissions
- AWS credentials configured

## Setup

### 1. Configure AWS Credentials

You can configure AWS credentials in several ways:

**Option A: Using `aws configure` (Interactive)**
```bash
aws configure
```

You'll be prompted for:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name (e.g., `us-east-1`)
- Default output format (e.g., `json`)

**Option B: Using Environment Variables**
```bash
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_DEFAULT_REGION=us-east-1
```

**Option C: Using Credentials File**
Create `~/.aws/credentials`:
```ini
[default]
aws_access_key_id = your_access_key
aws_secret_access_key = your_secret_key
```

Create `~/.aws/config`:
```ini
[default]
region = us-east-1
output = json
```

### 2. Verify Configuration

```bash
aws sts get-caller-identity
```

This should return your AWS account information if configured correctly.

## Demo Scripts

### Basic Operations

1. **Create Table** - `create-table.sh`
   - Creates a sample DynamoDB table

2. **List Tables** - `list-tables.sh`
   - Lists all DynamoDB tables in your account

3. **Describe Table** - `describe-table.sh`
   - Shows detailed information about a table

4. **Put Item** - `put-item.sh`
   - Adds an item to a table

5. **Get Item** - `get-item.sh`
   - Retrieves an item from a table

6. **Query Table** - `query-table.sh`
   - Queries items using a partition key

7. **Scan Table** - `scan-table.sh`
   - Scans all items in a table

8. **Update Item** - `update-item.sh`
   - Updates an existing item

9. **Delete Item** - `delete-item.sh`
   - Deletes an item from a table

10. **Delete Table** - `delete-table.sh`
    - Deletes a DynamoDB table

### Running the Demo

1. First, configure your AWS credentials (see Setup section above)
2. Make scripts executable: `chmod +x dynamodb-demo/*.sh`
3. Run the scripts in order or individually as needed

## Example Table Schema

The demo uses a table called `demo-users` with:
- **Partition Key**: `user_id` (String)
- **Sort Key**: `email` (String) - optional
- **Attributes**: `name` (String), `age` (Number), `city` (String)

## Common Commands Reference

### Create Table
```bash
aws dynamodb create-table \
    --table-name demo-users \
    --attribute-definitions \
        AttributeName=user_id,AttributeType=S \
    --key-schema \
        AttributeName=user_id,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST
```

### Put Item
```bash
aws dynamodb put-item \
    --table-name demo-users \
    --item '{
        "user_id": {"S": "123"},
        "name": {"S": "John Doe"},
        "email": {"S": "john@example.com"},
        "age": {"N": "30"}
    }'
```

### Get Item
```bash
aws dynamodb get-item \
    --table-name demo-users \
    --key '{"user_id": {"S": "123"}}'
```

### Query
```bash
aws dynamodb query \
    --table-name demo-users \
    --key-condition-expression "user_id = :uid" \
    --expression-attribute-values '{":uid": {"S": "123"}}'
```

### Scan
```bash
aws dynamodb scan \
    --table-name demo-users
```

### Update Item
```bash
aws dynamodb update-item \
    --table-name demo-users \
    --key '{"user_id": {"S": "123"}}' \
    --update-expression "SET age = :age" \
    --expression-attribute-values '{":age": {"N": "31"}}'
```

### Delete Item
```bash
aws dynamodb delete-item \
    --table-name demo-users \
    --key '{"user_id": {"S": "123"}}'
```

### Delete Table
```bash
aws dynamodb delete-table \
    --table-name demo-users
```

## Notes

- Replace `demo-users` with your actual table name
- DynamoDB uses JSON format with type annotations (S=String, N=Number, etc.)
- Use `--output json` for JSON output or `--output table` for table format
- For production use, consider using IAM roles instead of access keys
