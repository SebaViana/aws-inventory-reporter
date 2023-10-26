# aws-inventory-reporter

This bash script gathers information about multiple AWS resources. This resources consist of S3 buckets, EC2 instances, Lambda functions and IAM users.

## How to use it

1. Ensure you have 'jq' installed and the AWS CLI, with the propper authentication.

2. Clone this repository.

3. Make the script executable:
```
chmod +x aws_inventory_reporter.sh
```

4. Run the script
```
./aws_inventory_reporter.sh
```

The output of this script will consist of specific information and the total amount of each resource mentioned above.  
The output is displayed on the screen and also saved in a file located in the reports/ folder within the current script directory. Use --no-file to prevent the script from creating an output file.  
The reports are named in the format aws_inventory_$(date +"%Y-%m-%d_%H-%M-%S").txt.  
