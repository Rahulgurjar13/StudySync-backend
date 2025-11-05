#!/bin/bash
# Render Build Script
echo "🚀 Starting build process..."

# Navigate to server directory
cd server

# Install dependencies
echo "📦 Installing dependencies..."
npm ci --production=false

echo "✅ Build completed successfully!"
