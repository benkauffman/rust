FROM rust:latest as builder

ENV CARGO_TERM_COLOR always
RUN apt-get update && apt-get install -y libpq-dev

WORKDIR /usr/src/docker-build

# create empty project for caching dependencies
RUN USER=root cargo init
COPY Cargo.lock ./Cargo.toml ./

# cache dependencies
RUN cargo install --path . --locked

# build project
COPY ./ .
RUN touch src/main.rs
RUN cargo install --path . --locked
RUN cargo build --release


# slim image for smaller size
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y libpq-dev curl
COPY --from=builder /usr/local/cargo/bin/sls-lambda-docker-rust /bin/
CMD ["sls-lambda-docker-rust"]

# FROM rust:latest AS builder

# RUN rustup target add x86_64-unknown-linux-musl
# RUN apt update && apt install -y musl-tools musl-dev
# RUN apt-get install -y build-essential
# RUN yes | apt install gcc-x86-64-linux-gnu

# WORKDIR /app

# COPY ./ .
# ENV RUSTFLAGS='-C linker=x86_64-linux-gnu-gcc'
# RUN cargo build --target x86_64-unknown-linux-musl --release

# FROM scratch

# WORKDIR /app
# COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/sls-lambda-docker-rust ./
# CMD ["/app/sls-lambda-docker-rust"]
