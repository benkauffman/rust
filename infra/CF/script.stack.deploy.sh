#!/bin/bash
cd "$(dirname "$0")"

# default AWS_PROFILE to krashidbuilt if not set
export AWS_PROFILE=${AWS_PROFILE:-krashidbuilt}

aws cloudformation deploy \
    --stack-name rust-test-vpc \
    --template-file $(pwd)/public-private-vpc.yml \
    --capabilities CAPABILITY_NAMED_IAM \
    --region us-east-1

# aws cloudformation deploy \
#     --stack-name rust-test-lb \
#     --template-file $(pwd)/private-subnet-public-loadbalancer.yml \
#     --capabilities CAPABILITY_NAMED_IAM \
#     --region us-east-1
