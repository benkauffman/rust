#!/bin/bash

### Guide to deploy to AWS Lambda using Serverless Framework
# https://scicoding.com/serverless-rust-introduction/

### Setup local cross compiling

# https://betterprogramming.pub/cross-compiling-rust-from-mac-to-linux-7fad5a454ab1
# add cross-compiling targets
rustup target add x86_64-unknown-linux-musl
rustup target add x86_64-unknown-linux-gnu

# install musl
brew install FiloSottile/musl-cross/musl-cross

# install gnu
brew install SergioBenitez/osxct/x86_64-unknown-linux-gnu

# adding the linker for the targets
configFile=~/.cargo/config.toml
touch ${configFile}

echo `
[target.x86_64-unknown-linux-gnu]
linker = "x86_64-unknown-linux-gnu-gcc"
` >> ${configFile}

echo `
[target.x86_64-unknown-linux-musl]
linker = "x86_64-linux-musl-gcc"
` >> ${configFile}