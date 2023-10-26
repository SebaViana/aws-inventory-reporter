#!/bin/bash

# S3, EC2, Lambda, IAM Users

buckets=$(aws s3api list-buckets --output json | jq -r '.Buckets[] | "\(.Name), \(.CreationDate)"')
echo "######### S3 buckets #########"
echo "$buckets"

instances=$(aws ec2 describe-instances | jq -r '.Reservations[] | .Instances[] | "\(.InstanceId), \(.State.Name)"')
echo "######### EC2 instances ##########"
echo "$instances"

lambda=$(aws lambda list-functions | jq -r '.Functions[] | "\(.FunctionName), \(.Runtime)"')
echo "######### Lambda functions #########"
echo "$lambda"

users=$(aws iam list-users | jq -r '.Users[] | "\(.UserName), \(.CreateDate)"')
echo "######### IAM users #########"
echo "$users"
