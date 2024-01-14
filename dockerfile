# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install essential tools and dependencies
RUN apt-get update && \
    apt-get install -y curl build-essential

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Nano and Python
RUN apt-get install -y nano python3 python3-pip git

# Copy the local Cargo.toml and Cargo.lock files to the container
COPY Cargo.toml Cargo.lock ./

# Copy the source code into the container
COPY . .

# Install clippy
RUN rustup component add clippy

RUN apt-get update &&  apt install -y python3.10-venv

RUN python3 -m venv venv

# Clean up
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Specify the command to run on container start
CMD ["/bin/bash"]
