# Firecrawl Self-Hosted UI Setup

This UI allows you to interact with your self-hosted Firecrawl API for web scraping and crawling.

## Prerequisites

- Node.js 16.x or higher
- npm or yarn
- A running Firecrawl API server

## Quick Setup

1. **Edit configuration**:
   - Open `src/config.ts`
   - Update `FIRECRAWL_API_URL` to point to your Firecrawl API (e.g., `http://localhost:3003`)
   - Update `FIRECRAWL_API_KEY` with your API key

2. **Option 1: Using the setup script**:
   ```bash
   # Make the script executable if needed
   chmod +x start-ui.sh
   
   # Run the setup script
   ./start-ui.sh
   ```

3. **Option 2: Manual setup**:
   ```bash
   # Install dependencies
   npm install
   
   # Start the development server
   npm run dev
   ```

4. Access the UI at `http://localhost:5173`

## Security Considerations

For production use, consider:

1. Moving API calls to a server-side application to protect your API key
2. Implementing proper authentication
3. Setting up CORS policies

## Docker Deployment (Optional)

To add the UI to your docker-compose.yaml:

```yaml
services:
  # ... existing services ...
  
  ui:
    build: apps/ui/ingestion-ui
    ports:
      - "5173:5173"
    environment:
      - VITE_API_URL=http://api:3003
    volumes:
      - ./apps/ui/ingestion-ui:/app
    depends_on:
      - api
```

## Troubleshooting

- If you can't connect to the API, check:
  - Your API is running and accessible
  - The API URL is correctly configured in `src/config.ts`
  - Your API key is valid
  - CORS is properly configured on your API server

- If you see UI errors, check your browser console for more details 