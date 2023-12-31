#!/bin/bash

# cross compiling rust
# https://github.com/cross-rs/cross
# https://kerkour.com/rust-reproducible-cross-compilation-with-docker

# snippet for cross compiling rust on mac
# https://gist.github.com/shqld/256e2c4f4b97957fb0ec250cdc6dc463
# brew tap messense/macos-cross-toolchains
# brew install x86_64-unknown-linux-gnu

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