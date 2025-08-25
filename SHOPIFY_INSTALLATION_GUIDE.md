# 🛍️ Installing Your Shopify Store Sync App on a Live Store

This guide walks you through the complete process of installing your Store Sync app on a real Shopify store.

## 📋 Prerequisites

Before starting, ensure you have:
- [ ] A Shopify Partner account
- [ ] A development or live Shopify store
- [ ] Your app deployed to a public URL (Vercel, Netlify, etc.)
- [ ] Basic understanding of Shopify app development

## 🚀 Step-by-Step Installation Process

### Phase 1: Deploy Your App to Production

#### Option A: Quick Deploy to Vercel (Recommended)

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Deploy Shopify Store Sync App"
   git branch -M main
   git remote add origin https://github.com/yourusername/shopify-store-sync.git
   git push -u origin main
   ```

2. **Deploy to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Click "New Project"
   - Import your GitHub repository
   - Vercel will auto-detect Next.js settings

3. **Configure Environment Variables in Vercel**
   - Go to your project settings
   - Navigate to "Environment Variables"
   - Add these variables:
   ```
   SHOPIFY_API_KEY=your_shopify_api_key
   SHOPIFY_API_SECRET=your_shopify_api_secret
   NEXTAUTH_SECRET=your_random_32_char_secret
   NEXTAUTH_URL=https://your-app-name.vercel.app
   ```

4. **Note Your Production URL**
   - Your app will be available at: `https://your-app-name.vercel.app`

### Phase 2: Create Shopify App in Partner Dashboard

1. **Access Shopify Partners**
   - Go to [partners.shopify.com](https://partners.shopify.com)
   - Sign in to your Partner account

2. **Create New App**
   - Click "Apps" in the sidebar
   - Click "Create app"
   - Choose "Create app manually"

3. **Configure App Settings**
   ```
   App name: Store Sync App
   App URL: https://your-app-name.vercel.app
   Allowed redirection URL(s): 
     https://your-app-name.vercel.app/api/auth/shopify/callback
   ```

4. **Set App Scopes**
   In the "App setup" section, add these scopes:
   ```
   read_products,write_products,
   read_themes,write_themes,
   read_content,write_content,
   read_customers,write_customers,
   read_orders,write_orders,
   read_applications,write_applications,
   read_webhooks,write_webhooks,
   read_shipping,write_shipping,
   read_inventory,write_inventory,
   read_locations,read_users,write_users,
   read_checkouts,write_checkouts,
   read_reports,read_price_rules,write_price_rules,
   read_marketing_events,write_marketing_events,
   read_resource_feedbacks,write_resource_feedbacks,
   read_locales,write_locales
   ```

5. **Get API Credentials**
   - Copy your "Client ID" (API Key)
   - Copy your "Client secret" (API Secret)

### Phase 3: Update Your App Configuration

1. **Update Environment Variables**
   - Go back to Vercel dashboard
   - Update environment variables with your real Shopify credentials:
   ```
   SHOPIFY_API_KEY=your_actual_client_id
   SHOPIFY_API_SECRET=your_actual_client_secret
   ```

2. **Update shopify.app.toml**
   ```toml
   name = "store-sync-app"
   client_id = "your_actual_client_id"
   application_url = "https://your-app-name.vercel.app"
   embedded = true

   [access_scopes]
   scopes = "read_products,write_products,read_themes,write_themes,read_content,write_content"

   [auth]
   redirect_urls = [
     "https://your-app-name.vercel.app/api/auth/shopify/callback"
   ]
   ```

3. **Redeploy Your App**
   ```bash
   git add .
   git commit -m "Update production configuration"
   git push origin main
   ```
   Vercel will automatically redeploy.

### Phase 4: Install App on Your Shopify Store

#### Method 1: Direct Installation URL

1. **Create Installation URL**
   Replace `your-store` and `your-app-name` with actual values:
   ```
   https://your-store.myshopify.com/admin/oauth/authorize?client_id=your_client_id&scope=read_products,write_products,read_themes,write_themes&redirect_uri=https://your-app-name.vercel.app/api/auth/shopify/callback&state=random_state_string
   ```

2. **Visit Installation URL**
   - Open the URL in your browser
   - You'll be redirected to Shopify's OAuth consent screen

#### Method 2: Using App Installation Flow

1. **Visit Your App URL**
   ```
   https://your-app-name.vercel.app/?shop=your-store.myshopify.com
   ```

2. **Follow OAuth Flow**
   - Your middleware will redirect to the installation endpoint
   - Shopify will show the permission consent screen
   - Click "Install app"

### Phase 5: Test Your Installation

1. **Verify Installation**
   - After clicking "Install app", you should be redirected back to your app
   - You should see your sync dashboard
   - Check that no authentication errors appear

2. **Test Basic Functionality**
   - Try accessing the sync page: `https://your-app-name.vercel.app/sync?shop=your-store`
   - Test the export functionality
   - Verify API endpoints are working

### Phase 6: Configure for Multiple Stores

1. **Install on Second Store**
   - Repeat the installation process for your second store
   - Use the same app but different store domain

2. **Test Store-to-Store Sync**
   - Export configuration from Store 1
   - Import configuration to Store 2
   - Verify data synchronization works

## 🔧 Troubleshooting Common Issues

### Issue 1: "App installation failed"
**Cause**: Redirect URL mismatch
**Solution**: 
- Ensure redirect URLs in Shopify Partner Dashboard match exactly
- Check for trailing slashes or HTTP vs HTTPS

### Issue 2: "Invalid API credentials"
**Cause**: Wrong API key or secret
**Solution**:
- Double-check API credentials in Vercel environment variables
- Ensure you're using Client ID as API Key

### Issue 3: "Permission denied" errors
**Cause**: Missing required scopes
**Solution**:
- Review and add all required scopes in Partner Dashboard
- Reinstall the app to get new permissions

### Issue 4: App not loading in Shopify admin
**Cause**: CSP or frame options issues
**Solution**:
- Verify your middleware is setting correct headers
- Check that `embedded = true` in shopify.app.toml

### Issue 5: OAuth callback errors
**Cause**: Callback URL not handling parameters correctly
**Solution**:
- Check your callback route implementation
- Verify state parameter validation

## 📱 Making Your App Public (Optional)

### 1. App Review Preparation
- [ ] Test thoroughly on multiple stores
- [ ] Create app listing content
- [ ] Prepare screenshots and descriptions
- [ ] Ensure compliance with Shopify policies

### 2. Submit for Review
- In Partner Dashboard, go to "App setup"
- Click "Submit for review"
- Fill out the app listing information
- Wait for Shopify's approval

### 3. App Store Listing
- Once approved, your app will be available in the Shopify App Store
- Merchants can install it directly from their admin

## 🎯 Success Checklist

After completing installation, verify:
- [ ] App appears in store's "Apps" section
- [ ] OAuth authentication works correctly
- [ ] Export functionality works
- [ ] Import functionality works
- [ ] No console errors in browser
- [ ] API endpoints respond correctly
- [ ] Data synchronization between stores works
- [ ] App works in Shopify admin embedded frame

## 📞 Getting Help

If you encounter issues:

1. **Check Logs**
   - Vercel: Check function logs in dashboard
   - Browser: Check console for JavaScript errors
   - Network: Check API request/response in dev tools

2. **Common Resources**
   - [Shopify App Development Docs](https://shopify.dev/docs/apps)
   - [Shopify Partner Community](https://community.shopify.com/c/shopify-partners/ct-p/partners)
   - [Next.js Deployment Docs](https://nextjs.org/docs/deployment)

3. **Debug Steps**
   - Test API endpoints directly with curl
   - Verify environment variables are set correctly
   - Check Shopify webhook logs in Partner Dashboard

---

## 🎉 Congratulations!

Your Shopify Store Sync app is now live and installed on real Shopify stores! Merchants can now:

- Export complete store configurations
- Import configurations to other stores
- Sync themes, products, and settings
- Manage multiple store setups efficiently

**Your app is ready for production use! 🚀**
