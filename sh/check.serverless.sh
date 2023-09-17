#!/bin/bash
# exit script if any command fails
set -e

# if ./serverless.yml does not exist, exit
if [ ! -f ${1}/serverless.yml ]; then
    echo "./serverless.yml not found at the current location: $(pwd)"
    exit 1
fi
