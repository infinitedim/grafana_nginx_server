#!/bin/bash
set -e

echo "🚀 Starting Grafana + Nginx on Railway..."

# Install docker-compose if not available
if ! command -v docker-compose &> /dev/null; then
    echo "📦 Installing docker-compose..."
    curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Create necessary directories
echo "📁 Setting up directories..."
mkdir -p grafana nginx

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Error: docker-compose.yml not found!"
    exit 1
fi

# Start services with docker-compose
echo "🐳 Starting Docker containers..."
docker-compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 10

# Check if Grafana is running
if curl -s http://localhost:3000/api/health > /dev/null; then
    echo "✅ Grafana is running on port 3000"
else
    echo "⚠️  Grafana might not be ready yet"
fi

# Check if Nginx is running
if curl -s http://localhost:80 > /dev/null; then
    echo "✅ Nginx is running on port 80"
else
    echo "⚠️  Nginx might not be ready yet"
fi

echo "🎉 Deployment complete!"
echo "📊 Grafana: http://localhost:3000"
echo "🌐 Nginx proxy: http://localhost:80"

# Keep container running and show logs
docker-compose logs -f