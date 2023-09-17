#!/bin/bash
# exit script if any command fails
set -e

# set working directory to script directory
cd "$(dirname "$0")"

# set AWS_PROFILE environment variable if not defined, default to krashidbuilt
export AWS_PROFILE=${AWS_PROFILE:-krashidbuilt}

# set AWS_DEFAULT_REGION environment variable if not defined, default to us-east-1
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-us-east-1}

# set STAGE environment variable if not defined, default to development
export STAGE=${STAGE:-development}

# create service linked role in aws if not exists
aws iam get-role --role-name AWSServiceRoleForECS --region ${REGION} || aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com --region ${REGION}

# deploy to AWS Fargate
npx sls deploy --aws-profile ${AWS_PROFILE} --region ${REGION} --stage ${STAGE} --verbose
