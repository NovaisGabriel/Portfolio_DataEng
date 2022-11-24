#!/bin/bash
set -e


### Check terraform format

cd infrastructure/aws/
terraform fmt
terraform fmt -check
cd ../../

#####################