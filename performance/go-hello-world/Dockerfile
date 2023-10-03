# Use the official Golang image to create a build artifact.
FROM golang:latest as builder

# Set the working directory outside $GOPATH to enable the support for modules.
WORKDIR /src

COPY ./go.mod ./go.mod
COPY ./go.sum ./go.sum

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed.
RUN go mod download

# Copy local code to the container image.
COPY ./main.go ./main.go

# Build the binary.
RUN CGO_ENABLED=0 GOOS=linux go build -v -o app

# Use a minimal alpine image for the runtime container
FROM alpine:latest

# Copy the binary to the production image from the builder stage.
COPY --from=builder /src/app /app

# use release mode
ENV GIN_MODE=release

# Run the binary.
ENTRYPOINT ["/app"]

# Expose the necessary port (if your app serves HTTP, for example)
EXPOSE 8083

# Adjust the healthcheck to match your app's behavior
HEALTHCHECK --interval=15s --timeout=3s \
    CMD wget --quiet --tries=1 --spider http://localhost:8083/_health || exit 1