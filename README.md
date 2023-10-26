# aws-inventory-reporter

This bash script gathers information about multiple AWS resources. This resources consist of S3 buckets, EC2 instances, Lambda functions and IAM users.

## How to use it

1. Ensure you have 'jq' installed and the AWS CLI, with the propper authentication.

2. Clone this repository.

3. Make the script executable:
```
chmod +x aws-inventory-reporter.sh
```

4. Run the script
```
./aws-inventory-reporter.sh
```

The output of this script will consist of information about each of each resource mentioned above.
