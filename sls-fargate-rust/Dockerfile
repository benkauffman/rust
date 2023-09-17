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
COPY --from=builder /usr/local/cargo/bin/sls-fargate-rust /bin/
EXPOSE 8080
CMD ["sls-fargate-rust"]