#!/bin/bash
# exit script if any command fails
set -e

# confirm that you want to run this script
read -p "Are you sure you want to remove the serverless application? (y/n) " -n 1 -r

# set working directory to script directory
cd "$(dirname "$0")"

# load standardized deployment variables
source ../infra/deployment.variables.sh

# remove serverless application
npx sls remove --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose
