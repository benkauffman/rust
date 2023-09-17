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

# get logs for serverless application
npx sls logs --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose --tail --function func