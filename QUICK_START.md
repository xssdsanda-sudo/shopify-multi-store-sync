# 🚀 Quick Start: Install on Shopify Store

Follow these steps to get your Store Sync app installed on a Shopify store in under 10 minutes.

## ⚡ Super Quick Setup

### Step 1: Run Setup Script
```bash
npm run setup:shopify
```

### Step 2: Deploy to Vercel (1-Click)
[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/yourusername/shopify-store-sync&env=SHOPIFY_API_KEY,SHOPIFY_API_SECRET,NEXTAUTH_SECRET,NEXTAUTH_URL)

### Step 3: Create Shopify App
1. Go to [partners.shopify.com](https://partners.shopify.com)
2. Click "Create app" → "Create app manually"
3. Fill in:
   - **App name**: Store Sync App
   - **App URL**: `https://your-app.vercel.app`
   - **Redirect URL**: `https://your-app.vercel.app/api/auth/shopify/callback`

### Step 4: Configure Environment Variables
In your Vercel dashboard, add:
```env
SHOPIFY_API_KEY=your_client_id_from_shopify
SHOPIFY_API_SECRET=your_client_secret_from_shopify
NEXTAUTH_SECRET=any_random_32_character_string
NEXTAUTH_URL=https://your-app.vercel.app
```

### Step 5: Install on Your Store
Visit: `https://your-app.vercel.app/?shop=your-store.myshopify.com`

## 🎯 That's It!

Your app is now installed and ready to sync stores!

---

## 📋 Detailed Guides Available

- **SHOPIFY_INSTALLATION_GUIDE.md** - Complete step-by-step guide
- **DEPLOYMENT.md** - Detailed deployment options
- **DEPLOYMENT_CHECKLIST.md** - Pre-launch checklist

## 🆘 Need Help?

1. **Check the logs** in Vercel dashboard
2. **Verify environment variables** are set correctly
3. **Test API endpoints** directly
4. **Review troubleshooting** in SHOPIFY_INSTALLATION_GUIDE.md

## 🎉 Success!

Once installed, you can:
- Export store configurations as JSON
- Import configurations to other stores
- Sync themes, products, collections, and more
- Manage multiple store setups efficiently

**Your Shopify Store Sync app is live! 🛍️**
