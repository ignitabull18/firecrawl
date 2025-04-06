#!/bin/bash

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Firecrawl UI Setup ===${NC}"

# Check if node is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js is not installed. Please install Node.js before continuing.${NC}"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}npm is not installed. Please install npm before continuing.${NC}"
    exit 1
fi

# Install dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
npm install

# Check if config.ts exists and has been modified from default
if grep -q "fc-YOUR_API_KEY" src/config.ts; then
    echo -e "${YELLOW}WARNING: You haven't set your Firecrawl API key in src/config.ts.${NC}"
    echo -e "${YELLOW}Please edit src/config.ts to set your API URL and key before using the UI.${NC}"
fi

# Start the development server
echo -e "${GREEN}Starting UI development server...${NC}"
echo -e "${GREEN}The UI will be available at http://localhost:5173${NC}"
npm run dev 