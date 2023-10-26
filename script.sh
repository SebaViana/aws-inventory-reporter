#!/bin/bash

# Function to count and display total instances for a given resource
count_instances() {
    local resource_name="$1"
    local instances="$2"
    local count

    count=$(echo "$instances" | wc -l)
    echo "Total $resource_name: $count"
}


# Get the directory where the script is located
script_directory="$( cd "$(dirname "$0")" ; pwd -P )"

# Define output file in the same directory as the script
output_file="$script_directory/reports/aws_inventory_$(date +"%Y-%m-%d_%H-%M-%S").txt"

# S3, EC2, Lambda, IAM Users

buckets=$(aws s3api list-buckets --output json | jq -r '.Buckets[] | "\(.Name), \(.CreationDate)"')
{
    echo "######### S3 buckets #########"
    echo "Bucket name, Creation date"
    echo "$buckets"
    count_instances "S3 buckets" "$buckets"
} | tee -a "$output_file"

instances=$(aws ec2 describe-instances | jq -r '.Reservations[] | .Instances[] | "\(.InstanceId), \(.State.Name)"')
{
    echo "######### EC2 instances ##########"
    echo "Instance ID, State"
    echo "$instances"
    count_instances "EC2 instances" "$instances"
} | tee -a "$output_file"

lambda=$(aws lambda list-functions | jq -r '.Functions[] | "\(.FunctionName), \(.Runtime)"')
{
    echo "######### Lambda functions #########"
    echo "Function name, Runtime"
    echo "$lambda"
    count_instances "Lambda functions" "$lambda"
} | tee -a "$output_file"

users=$(aws iam list-users | jq -r '.Users[] | "\(.UserName), \(.CreateDate)"')
{
    echo "######### IAM users #########"
    echo "User name, Create date"
    echo "$users"
    count_instances "IAM users" "$users"
} | tee -a "$output_file"
