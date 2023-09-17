#!/bin/bash
# exit script if any command fails
set -e

SERVERLESS_FILE_PATH=${1}/serverless.yml

echo checking serverless file exists at: ${SERVERLESS_FILE_PATH}

# check serverless file exists
if [ ! -f ${SERVERLESS_FILE_PATH} ]; then
    echo "Could not find serverless file at: ${SERVERLESS_FILE_PATH}"
    exit 1
fi
