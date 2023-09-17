#!/bin/bash
# exit script if any command fails
set -e

# set working directory to script directory
cd "$(dirname "$0")"

# load standardized deployment variables
source ../infra/deployment.variables.sh

# create service linked role in aws if not exists
aws iam get-role --role-name AWSServiceRoleForECS --region ${AWS_DEFAULT_REGION} || aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com --region ${AWS_DEFAULT_REGION}

# deploy to AWS Fargate
npx sls deploy --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose
