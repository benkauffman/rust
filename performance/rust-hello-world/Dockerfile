FROM rust:latest

# COPY ./Cargo.toml ./Cargo.toml
# COPY ./Cargo.lock ./Cargo.lock

# # Create dummy source code to build dependencies
# RUN mkdir ./src
# RUN echo "fn main() {}" > ./src/main.rs

# # Build your dependencies for caching
# RUN cargo install --path .

# # Remove the dummy source code
# RUN rm -rf ./src

# # build the real stuff and disable cache via the ADD
# ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
# # copy source code
# COPY ./src ./src

COPY . .

# Build your program for release
RUN cargo build --release

# expose port 8080
EXPOSE 8080

# Run the binary
CMD ["./target/release/rust-hello-world"]

# Add a healthcheck
HEALTHCHECK --interval=15s --timeout=3s \
    CMD curl -f http://localhost:8080/_health || exit 1