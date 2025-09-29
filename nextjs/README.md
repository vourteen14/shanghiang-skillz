# Next.js Application

## Requirements
- Docker & Docker Compose
- Node.js 20+ (for local development)

## Build & Run

### Docker (Recommended)
```bash
docker-compose up --build

docker build -t nextjs-app . && docker run -p 3000:3000 nextjs-app
```

### Local Development
```bash
cd app/
npm install
npm test
npm run dev
```

## Architecture
- Build => Multi-stage Docker (Node.js 20 → Alpine)
- Size => ~150MB production image (70% smaller than single-stage)
- Testing => Jest with coverage reports during build
- Port => 3000 (configurable via Docker)

## Build Process
1. Install dependencies
2. Run test suite with coverage
3. Generate production build
4. Copy artifacts to Alpine
5. Expose port 3000

Application available at `http://localhost:3000`