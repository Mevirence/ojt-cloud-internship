#!/bin/bash
###############################################
# aws-inventory.sh
# Description : Lists key AWS resources
# Usage       : ./aws-inventory.sh
# Requires    : aws cli configured
###############################################

REGION="ap-southeast-1"

echo "===== AWS Inventory ====="
echo "Region: $REGION"
echo ""

echo "-- EC2 Instances --"
aws ec2 describe-instances \
  --region "$REGION" \
  --query "Reservations[].Instances[].[InstanceId,InstanceType,State.Name]" \
  --output table

echo "-- S3 Buckets --"
aws s3 ls

echo "-- Security Groups --"
aws ec2 describe-security-groups \
  --region "$REGION" \
  --query "SecurityGroups[].[GroupId,GroupName]" \
  --output table

echo "-- IAM Users --"
aws iam list-users \
  --query "Users[].UserName" \
  --output table

echo ""
echo "===== Done ====="