#!/bin/bash
# exit script if any command fails
set -e

rm -rf node_modules
rm -rf .serverless
rm -rf target

npm install
cargo clean