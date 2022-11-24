#!/bin/bash
set -e

#### Terraform Plan #####

./CI/scripts/pre_terraform.sh

cd infrastructure/aws/
terraform init
terraform state replace-provider -auto-approve registry.terraform.io/-/aws registry.terraform.io/hashicorp/aws
terraform workspace select $1 || terraform workspace new $1
terraform plan
cd ../../

######################################