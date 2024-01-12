# Use the official Rust image as the base image
FROM rust:latest

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the local Cargo.toml and Cargo.lock files to the container
COPY Cargo.toml Cargo.lock ./

# Build and cache dependencies
RUN cargo build --release

# Copy the source code into the container
COPY src ./src

# Build the Rust application
RUN cargo build --release

# Specify the command to run on container start
CMD ["./target/release/my_rust_app"]
