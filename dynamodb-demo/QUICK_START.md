# Quick Start Guide

## 1. Configure AWS Credentials

```bash
aws configure
```

Enter your:
- AWS Access Key ID
- AWS Secret Access Key  
- Default region (e.g., `us-east-1`)
- Default output format (e.g., `json`)

## 2. Verify Setup

```bash
aws sts get-caller-identity
```

## 3. Run the Complete Demo

```bash
cd dynamodb-demo
./run-demo.sh
```

This will:
- Create a table
- Add sample data
- Query and scan items
- Update an item
- Show table details

## 4. Individual Operations

### Create Table
```bash
./create-table.sh
```

### Add Item
```bash
./put-item.sh user-123 "John Doe" "john@example.com" 30 "New York"
```

### Get Item
```bash
./get-item.sh user-123
```

### List All Items
```bash
./scan-table.sh
```

### Update Item
```bash
./update-item.sh user-123 age 31 N
```

### Delete Item
```bash
./delete-item.sh user-123
```

### Delete Table
```bash
./delete-table.sh
```

## Common Issues

**Error: Unable to locate credentials**
- Run `aws configure` to set up credentials

**Error: Table already exists**
- Use `./delete-table.sh` to remove existing table first
- Or use a different table name

**Error: Region not specified**
- Set `AWS_DEFAULT_REGION` environment variable
- Or use `aws configure` to set default region

## Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Explore AWS DynamoDB documentation: https://docs.aws.amazon.com/dynamodb/
- Try modifying the scripts for your use case
