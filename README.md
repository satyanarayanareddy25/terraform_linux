# terraform_linux
A Linux server on AWS that serves as a basic web server.

# Terraform Project Execution Guide

This guide will help you set up and execute the Terraform configuration to deploy infrastructure.

## Prerequisites

1. **Install Terraform**  
   Make sure Terraform is installed on your system. [Download Terraform](https://www.terraform.io/downloads.html) if necessary.

2. **Set Up AWS Credentials**  
   Configure your AWS credentials with the required permissions to create and manage resources. You can set up credentials by running:
   ```bash
   aws configure
Or by setting environment variables:


export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
Execution Steps
Clone the Repository


git clone https://github.com/satyanarayanareddy25/terraform_linux.git
cd terraform_linux
Initialize Terraform


terraform init
Review and Configure Variables
If there is a variables.tf file, review the required variables. You may need to create a terraform.tfvars file to set values:


# terraform.tfvars example
region = "us-west-2"
instance_type = "t2.micro"
Run Terraform Plan


terraform plan
Apply Terraform Configuration

terraform apply
Connect to Your Linux Instance


ssh -i <path-to-your-private-key> ubuntu@<instance-public-ip>
Cleanup
To delete the resources created, run:

terraform destroy
Notes
Ensure your SSH key permissions are secure (e.g., chmod 400 <private-key>).
For more customization, edit the main.tf and other .tf files as needed.


---

This README file is concise and aligned, ready for users to follow each step easily.
