#!/bin/bash

# Function to count and display total instances for a given resource
count_instances() {
    local resource_name="$1"
    local instances="$2"
    local count

    count=$(echo "$instances" | wc -l)
    echo "Total $resource_name: $count"
}

# S3, EC2, Lambda, IAM Users

buckets=$(aws s3api list-buckets --output json | jq -r '.Buckets[] | "\(.Name), \(.CreationDate)"')
echo "######### S3 buckets #########"
echo "$buckets"
count_instances "S3 buckets" "$buckets"

instances=$(aws ec2 describe-instances | jq -r '.Reservations[] | .Instances[] | "\(.InstanceId), \(.State.Name)"')
echo "######### EC2 instances ##########"
echo "$instances"
count_instances "EC2 instances" "$instances"

lambda=$(aws lambda list-functions | jq -r '.Functions[] | "\(.FunctionName), \(.Runtime)"')
echo "######### Lambda functions #########"
echo "$lambda"
count_instances "Lambda functions" "$lambda"

users=$(aws iam list-users | jq -r '.Users[] | "\(.UserName), \(.CreateDate)"')
echo "######### IAM users #########"
echo "$users"
count_instances "IAM users" "$users"
