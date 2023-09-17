#!/bin/bash

# set AWS_PROFILE environment variable if not defined, default to krashidbuilt
export AWS_PROFILE=${AWS_PROFILE:-krashidbuilt}

# set AWS_DEFAULT_REGION environment variable if not defined, default to us-east-1
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-us-east-1}

# set STAGE environment variable if not defined, default to development
export STAGE=${STAGE:-development}
# export STAGE=${STAGE:-dev}

echo
echo AWS_DEFAULT_REGION : $AWS_DEFAULT_REGION
echo AWS_PROFILE        : $AWS_PROFILE
echo STAGE              : $STAGE
echo