# 🚀 Aurelia MindScape Deployment Guide

## GitHub Repository Setup

1. **Create Repository on GitHub**
   - Go to https://github.com/new
   - Repository name: `aurelia-mindscape`
   - Description: "Next-Gen AI Emotional Intelligence Platform"
   - Set to Public
   - Don't initialize with README (we already have one)

2. **Push to GitHub**
   ```bash
   # Add remote origin
   git remote add origin https://github.com/dugadak/aurelia-mindscape.git
   
   # Push to main branch
   git branch -M main
   git push -u origin main
   ```

## Local Development Setup

### Backend Setup
```bash
cd server
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt

# Create .env file with your API keys
echo "OPENAI_API_KEY=your-key-here" > .env
echo "DATABASE_URL=postgresql://localhost/aurelia" >> .env

# Run server
uvicorn main:app --reload --port 8888
```

### Flutter App Setup
```bash
cd app
flutter pub get
flutter run
```

## Docker Deployment
```bash
# Build and run with Docker Compose
docker-compose up -d
```

## Production Deployment

### Backend (AWS/GCP)
1. Set up PostgreSQL database
2. Configure Redis cache
3. Deploy with Docker or directly on EC2/Compute Engine
4. Set up SSL certificates
5. Configure environment variables

### Mobile App
1. Build for Android:
   ```bash
   flutter build apk --release
   ```

2. Build for iOS:
   ```bash
   flutter build ios --release
   ```

## Environment Variables

Create `.env` file in server directory:
```env
# Core
SECRET_KEY=your-secret-key-here
DEBUG=False

# Database
DATABASE_URL=postgresql://user:pass@localhost/aurelia
REDIS_URL=redis://localhost:6379

# AI Services
OPENAI_API_KEY=your-openai-key
GPT_MODEL=gpt-4-turbo-preview

# Security
JWT_SECRET=your-jwt-secret
```

## API Documentation

Once the server is running, visit:
- Swagger UI: http://localhost:8888/neural-docs
- ReDoc: http://localhost:8888/quantum-docs

## Monitoring

- Health check: http://localhost:8888/health
- Metrics: http://localhost:8888/metrics (if Prometheus enabled)

## Support

For issues or questions, please open an issue on GitHub.