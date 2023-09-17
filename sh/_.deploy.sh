#!/bin/bash
# exit script if any command fails
set -e

# get current working directory so we can return to it later
CALLER_DIR=$(pwd)

# set working directory to script directory
cd "$(dirname "$0")"

# check serverless file exists
source './check.serverless.sh' "${CALLER_DIR}"

# load standardized deployment variables
source ./variables.sh

# return to the original working directory
cd ${CALLER_DIR}

# if serverless.yml exists and contains "fargate" then run the create service link role
if grep -q "fargate" ./serverless.yml; then
    # create service linked role in aws if not exists
    aws iam get-role --role-name AWSServiceRoleForECS --region ${AWS_DEFAULT_REGION} || aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com --region ${AWS_DEFAULT_REGION}
fi

# create certificate in aws if it doesn't exist
npx sls create-cert --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose

# sls create domain
npx sls create_domain --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose

# deploy to AWS Fargate
npx sls deploy --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose
