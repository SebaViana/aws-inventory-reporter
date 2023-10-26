#!/bin/bash

# Function to count and display total instances for a given resource
count_instances() {
    local resource_name="$1"
    local instances="$2"
    local count

    count=$(echo "$instances" | wc -l)
    echo "Total $resource_name: $count"
}

# Check if the --no-file argument is passed
if [ "$1" = "--no-file" ]; then
    no_file=true
else
    no_file=false
fi

if [ "$no_file" = false ]; then
	# Get the directory where the script is located
	script_directory="$( cd "$(dirname "$0")" ; pwd -P )"

	# Define output file in the same directory as the script
	output_file="$script_directory/reports/aws_inventory_$(date +"%Y-%m-%d_%H-%M-%S").txt"
fi

# Function to handle output redirection
output_to_file() {
    if [ "$no_file" = false ]; then
        tee -a "$output_file"
    else
	cat
    fi
}
# S3, EC2, Lambda, IAM Users

buckets=$(aws s3api list-buckets --output json | jq -r '.Buckets[] | "\(.Name), \(.CreationDate)"')
{
    echo "######### S3 buckets #########"
    echo "Bucket name, Creation date"
    echo "$buckets"
    count_instances "S3 buckets" "$buckets"
} | output_to_file

instances=$(aws ec2 describe-instances | jq -r '.Reservations[] | .Instances[] | "\(.InstanceId), \(.State.Name)"')
{
    echo "######### EC2 instances ##########"
    echo "Instance ID, State"
    echo "$instances"
    count_instances "EC2 instances" "$instances"
} | output_to_file

lambda=$(aws lambda list-functions | jq -r '.Functions[] | "\(.FunctionName), \(.Runtime)"')
{
    echo "######### Lambda functions #########"
    echo "Function name, Runtime"
    echo "$lambda"
    count_instances "Lambda functions" "$lambda"
} | output_to_file

users=$(aws iam list-users | jq -r '.Users[] | "\(.UserName), \(.CreateDate)"')
{
    echo "######### IAM users #########"
    echo "User name, Create date"
    echo "$users"
    count_instances "IAM users" "$users"
} | output_to_file
