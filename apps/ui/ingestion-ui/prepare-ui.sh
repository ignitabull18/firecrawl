#!/bin/bash

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Firecrawl UI Preparation ===${NC}"

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

# Check if .env file exists in the root directory
ROOT_DIR=$(cd ../../.. && pwd)
if [ -f "$ROOT_DIR/.env" ]; then
    echo -e "${GREEN}Found .env file in root directory.${NC}"
    
    # Extract API key if it exists
    API_KEY=$(grep "FIRECRAWL_API_KEY" "$ROOT_DIR/.env" | cut -d '=' -f2)
    if [ -n "$API_KEY" ]; then
        echo -e "${GREEN}Found API key in .env file.${NC}"
        
        # Update config.ts with the API key
        if [ -f "src/config.ts" ]; then
            echo -e "${YELLOW}Updating API key in config.ts...${NC}"
            sed -i '' "s/fc-YOUR_API_KEY/$API_KEY/" src/config.ts
            echo -e "${GREEN}API key updated in config.ts${NC}"
        else
            echo -e "${RED}src/config.ts not found.${NC}"
        fi
    else
        echo -e "${YELLOW}API key not found in .env file. You will need to set it manually in src/config.ts.${NC}"
    fi
else
    echo -e "${YELLOW}No .env file found in the root directory. You will need to set the API key manually in src/config.ts.${NC}"
fi

echo -e "${GREEN}Preparation complete. You can now run ./start-ui.sh to start the UI.${NC}" 