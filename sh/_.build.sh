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

# install dependencies
cargo install --path . --locked

# set rust target to x86_64-unknown-linux-gnu if not defined
if [ -z "$RUST_TARGET" ]; then
    echo "RUST_TARGET not defined, defaulting to x86_64-unknown-linux-gnu"
    export RUST_TARGET=x86_64-unknown-linux-gnu
fi

# build rust binary target
cargo build --release --target ${RUST_TARGET}

# package serverless application
npx sls package --aws-profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} --stage ${STAGE} --verbose
