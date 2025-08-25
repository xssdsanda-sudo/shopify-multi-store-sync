# Deployment Guide: Shopify Store Sync App

This guide covers deploying your Shopify Store Sync app to various hosting platforms and configuring it as a live Shopify app.

## 🚀 Deployment Options

### Option 1: Vercel (Recommended)

Vercel provides excellent Next.js support and easy deployment.

#### Steps:

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/yourusername/shopify-store-sync.git
   git push -u origin main
   ```

2. **Deploy to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Import your GitHub repository
   - Configure environment variables:
     ```
     SHOPIFY_API_KEY=your_shopify_api_key
     SHOPIFY_API_SECRET=your_shopify_api_secret
     NEXTAUTH_SECRET=your_random_secret_key
     NEXTAUTH_URL=https://your-app-name.vercel.app
     ```

3. **Update Shopify App Configuration**
   - Update `shopify.app.toml` with your Vercel URL
   - Update redirect URLs in Shopify Partner Dashboard

#### Vercel CLI Deployment:
```bash
npm install -g vercel
vercel login
vercel --prod
```

### Option 2: Netlify

1. **Create netlify.toml**
   ```toml
   [build]
     command = "npm run build"
     publish = ".next"

   [build.environment]
     NODE_VERSION = "18"

   [[redirects]]
     from = "/api/*"
     to = "/.netlify/functions/:splat"
     status = 200

   [[headers]]
     for = "/sync"
     [headers.values]
       X-Frame-Options = "ALLOWALL"
       Content-Security-Policy = "frame-ancestors 'self' https://*.myshopify.com https://admin.shopify.com"
   ```

2. **Deploy Steps**
   - Connect your GitHub repository to Netlify
   - Set environment variables in Netlify dashboard
   - Deploy automatically on git push

### Option 3: Railway

1. **Deploy to Railway**
   ```bash
   npm install -g @railway/cli
   railway login
   railway init
   railway up
   ```

2. **Configure Environment Variables**
   - Set variables in Railway dashboard
   - Configure custom domain

### Option 4: DigitalOcean App Platform

1. **Create App Spec**
   ```yaml
   name: shopify-store-sync
   services:
   - name: web
     source_dir: /
     github:
       repo: yourusername/shopify-store-sync
       branch: main
     run_command: npm start
     environment_slug: node-js
     instance_count: 1
     instance_size_slug: basic-xxs
     envs:
     - key: SHOPIFY_API_KEY
       value: your_api_key
     - key: SHOPIFY_API_SECRET
       value: your_api_secret
   ```

## 🔧 Shopify App Configuration

### 1. Create Shopify App in Partner Dashboard

1. **Go to Shopify Partners**
   - Visit [partners.shopify.com](https://partners.shopify.com)
   - Create a new app

2. **App Settings**
   ```
   App name: Store Sync App
   App URL: https://your-domain.com
   Allowed redirection URL(s): 
     - https://your-domain.com/api/auth/shopify/callback
     - https://your-domain.com/api/auth/callback
   ```

3. **App Scopes** (Required permissions)
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

### 2. Update Configuration Files

1. **Update shopify.app.toml**
   ```toml
   name = "store-sync-app"
   client_id = "your_actual_api_key"
   application_url = "https://your-actual-domain.com"
   embedded = true

   [access_scopes]
   scopes = "read_products,write_products,read_themes,write_themes,read_content,write_content"

   [auth]
   redirect_urls = [
     "https://your-actual-domain.com/api/auth/shopify/callback"
   ]
   ```

2. **Update Environment Variables**
   ```env
   SHOPIFY_API_KEY=your_shopify_api_key
   SHOPIFY_API_SECRET=your_shopify_api_secret
   NEXTAUTH_SECRET=your_random_32_char_secret
   NEXTAUTH_URL=https://your-actual-domain.com
   ```

## 📱 Making it an Embedded Shopify App

### 1. Install Shopify App Bridge

```bash
npm install @shopify/app-bridge @shopify/app-bridge-react
```

### 2. Update Layout for Embedded App

Create `src/components/ShopifyProvider.tsx`:
```tsx
'use client'

import { AppProvider } from '@shopify/app-bridge-react';
import { useSearchParams } from 'next/navigation';

export default function ShopifyProvider({ children }: { children: React.ReactNode }) {
  const searchParams = useSearchParams();
  const shop = searchParams.get('shop');

  if (!shop) {
    return <div>Loading...</div>;
  }

  const config = {
    apiKey: process.env.NEXT_PUBLIC_SHOPIFY_API_KEY!,
    host: searchParams.get('host') || '',
    forceRedirect: true,
  };

  return (
    <AppProvider config={config}>
      {children}
    </AppProvider>
  );
}
```

### 3. Update Root Layout

```tsx
import ShopifyProvider from '@/components/ShopifyProvider';

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        <ShopifyProvider>
          {children}
        </ShopifyProvider>
      </body>
    </html>
  )
}
```

## 🔐 Security Considerations

### 1. Environment Variables
- Never commit API keys to version control
- Use platform-specific secret management
- Rotate keys regularly

### 2. HMAC Verification
- Verify webhook signatures
- Validate OAuth state parameters
- Implement CSRF protection

### 3. Rate Limiting
- Implement API rate limiting
- Handle Shopify API rate limits gracefully
- Use exponential backoff for retries

## 🚀 Going Live Checklist

### Pre-Launch
- [ ] Test app installation on development store
- [ ] Verify all API endpoints work correctly
- [ ] Test export/import functionality
- [ ] Check error handling and logging
- [ ] Validate environment variables
- [ ] Test OAuth flow completely

### Launch
- [ ] Deploy to production hosting
- [ ] Update Shopify app URLs
- [ ] Submit app for review (if public)
- [ ] Test installation on live stores
- [ ] Monitor error logs
- [ ] Set up monitoring and alerts

### Post-Launch
- [ ] Monitor app performance
- [ ] Collect user feedback
- [ ] Plan feature updates
- [ ] Maintain API compatibility
- [ ] Regular security updates

## 📊 Monitoring and Analytics

### 1. Error Tracking
```bash
npm install @sentry/nextjs
```

### 2. Analytics
```bash
npm install @vercel/analytics
```

### 3. Performance Monitoring
- Use Vercel Analytics
- Monitor API response times
- Track user engagement

## 🆘 Troubleshooting

### Common Issues

1. **OAuth Redirect Mismatch**
   - Ensure redirect URLs match exactly
   - Check for trailing slashes
   - Verify HTTPS in production

2. **CORS Issues**
   - Configure proper headers for embedded apps
   - Check Content-Security-Policy settings

3. **API Rate Limits**
   - Implement proper retry logic
   - Use bulk operations where possible
   - Monitor API usage

4. **Session Management**
   - Implement proper session storage
   - Handle session expiration
   - Validate tokens before API calls

## 📞 Support

For deployment issues:
- Check hosting platform documentation
- Review Shopify App development guides
- Monitor application logs
- Test in development environment first

---

**Ready to deploy your Shopify Store Sync app! 🚀**
