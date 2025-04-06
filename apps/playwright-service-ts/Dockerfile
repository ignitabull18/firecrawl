FROM node:18-slim

# Install essential dependencies first
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copy and install dependencies first (better caching)
COPY package*.json ./
RUN npm install --no-audit

# Install Playwright dependencies
RUN npx playwright install --with-deps chromium

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Set up port
ARG PORT=3000
ENV PORT=${PORT}
EXPOSE ${PORT}

# Set healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${PORT}/health || exit 1

# Run the application
CMD [ "npm", "start" ]
