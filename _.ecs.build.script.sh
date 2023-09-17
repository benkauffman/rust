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

# get project name from package.json
PROJECT_NAME=$(cat package.json | jq -r '.name')
echo "PROJECT_NAME: ${PROJECT_NAME}"

# git hash for tagging docker image
GIT_HASH=$(git rev-parse --short HEAD)
echo "GIT_HASH: ${GIT_HASH}"

# set region to match default region defined in AWS_DEFAULT_REGION environment variable
REGION=${AWS_DEFAULT_REGION}
echo "REGION: ${REGION}"

# get account number from aws cli
ACCOUNT_NUMBER=$(aws sts get-caller-identity --query Account --output text)
echo "ACCOUNT_NUMBER: ${ACCOUNT_NUMBER}"

# define ECR URI
ECR_URI=${ACCOUNT_NUMBER}.dkr.ecr.${REGION}.amazonaws.com
echo "ECR_URI: ${ECR_URI}"

# define ECR image URI
ECR_IMAGE_URI=${ECR_URI}/${PROJECT_NAME}:${GIT_HASH}
echo "ECR_IMAGE_URI: ${ECR_IMAGE_URI}"

# create service linked role in aws if not exists
aws iam get-role --role-name AWSServiceRoleForECS --region ${AWS_DEFAULT_REGION} || aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com --region ${AWS_DEFAULT_REGION}

# build the docker image
docker build --ssh default -t ${PROJECT_NAME} .

# create docker image repository if not exists
aws ecr describe-repositories --repository-names ${PROJECT_NAME} --region ${AWS_DEFAULT_REGION} || aws ecr create-repository --repository-name ${PROJECT_NAME} --region ${AWS_DEFAULT_REGION}

# login to AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_URI}

# tag docker image
docker tag ${PROJECT_NAME}:latest ${ECR_IMAGE_URI}

# push docker image to AWS ECR
docker push ${ECR_IMAGE_URI}
