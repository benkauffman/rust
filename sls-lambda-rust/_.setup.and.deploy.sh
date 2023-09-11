#!/bin/bash

export AWS_PROFILE=krashidbuilt
export STAGE=dev

npm install
cargo build --release --target x86_64-unknown-linux-musl
npm run package
npm run deploy
