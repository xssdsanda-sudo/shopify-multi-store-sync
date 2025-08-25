#!/bin/bash

# Shopify Store Sync App - Quick Setup Script
# This script helps you set up your app for Shopify installation

echo "🛍️  Shopify Store Sync App - Quick Setup"
echo "========================================"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

echo "📋 Pre-installation Checklist:"
echo ""

# Check if required files exist
echo "✅ Checking required files..."
required_files=("shopify.app.toml" "src/middleware.ts" "src/app/api/auth/install/route.ts" "src/app/api/auth/shopify/callback/route.ts")

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file exists"
    else
        echo "   ❌ $file missing"
        exit 1
    fi
done

echo ""
echo "🔧 Setup Steps:"
echo ""

echo "1. 📦 Install dependencies (if not already done):"
echo "   npm install"
echo ""

echo "2. 🌐 Deploy to Vercel:"
echo "   - Push your code to GitHub"
echo "   - Connect to Vercel"
echo "   - Note your production URL"
echo ""

echo "3. 🏪 Create Shopify App:"
echo "   - Go to https://partners.shopify.com"
echo "   - Create new app"
echo "   - Set App URL to your Vercel URL"
echo "   - Set redirect URL to: https://your-app.vercel.app/api/auth/shopify/callback"
echo ""

echo "4. 🔑 Configure Environment Variables:"
echo "   Add these to your Vercel project:"
echo "   - SHOPIFY_API_KEY=your_client_id"
echo "   - SHOPIFY_API_SECRET=your_client_secret"
echo "   - NEXTAUTH_SECRET=your_random_secret"
echo "   - NEXTAUTH_URL=https://your-app.vercel.app"
echo ""

echo "5. 🛍️  Install on Shopify Store:"
echo "   Visit: https://your-app.vercel.app/?shop=your-store.myshopify.com"
echo ""

echo "📖 For detailed instructions, see:"
echo "   - SHOPIFY_INSTALLATION_GUIDE.md"
echo "   - DEPLOYMENT.md"
echo "   - DEPLOYMENT_CHECKLIST.md"
echo ""

# Ask if user wants to start development server
read -p "🚀 Start development server now? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Starting development server on port 8000..."
    npm run dev
fi
