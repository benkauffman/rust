#!/bin/bash
# exit script if any command fails
set -e

# set working directory to script directory
cd "$(dirname "$0")"

# load standardized deployment variables
source ../infra/deployment.variables.sh

# build rust binary using musl
cargo build --release --target x86_64-unknown-linux-musl

# package serverless application
npx sls package --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose

# deploy to AWS Fargate
npx sls deploy --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose
