FROM node:22-slim

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

WORKDIR /app

# Install Go
RUN apt-get update && apt-get install -y golang git

# Install Rust
RUN apt-get install -y curl build-essential pkg-config libssl-dev
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Copy the entire app
COPY . .

# Install dependencies
RUN corepack enable
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install

# Build Go HTML to Markdown
RUN cd /app/sharedLibs/go-html-to-md && \
    go mod tidy && \
    go build -o html-to-markdown.so -buildmode=c-shared html-to-markdown.go && \
    chmod +x html-to-markdown.so

# Build Rust HTML Transformer
RUN cd /app/sharedLibs/html-transformer && \
    cargo build --release && \
    chmod +x target/release/libhtml_transformer.so

# Build app
RUN pnpm run build

# Make sure the entrypoint script has the correct line endings
RUN sed -i 's/\r$//' /app/docker-entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/app/docker-entrypoint.sh"]
