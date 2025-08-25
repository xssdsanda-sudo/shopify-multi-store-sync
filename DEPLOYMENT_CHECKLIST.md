# 🚀 Shopify Store Sync App - Deployment Checklist

## Pre-Deployment Setup

### 1. Shopify Partner Account Setup
- [ ] Create Shopify Partner account at [partners.shopify.com](https://partners.shopify.com)
- [ ] Create new app in Partner Dashboard
- [ ] Note down API Key and API Secret
- [ ] Configure app scopes (see DEPLOYMENT.md for full list)

### 2. Environment Configuration
- [ ] Copy `.env.example` to `.env.local`
- [ ] Fill in all required environment variables:
  ```env
  SHOPIFY_API_KEY=your_shopify_api_key
  SHOPIFY_API_SECRET=your_shopify_api_secret
  NEXTAUTH_SECRET=your_random_32_char_secret
  NEXTAUTH_URL=https://your-domain.com
  ```

### 3. Local Testing
- [ ] Run `npm run dev` locally
- [ ] Test export functionality with mock data
- [ ] Test import functionality with mock data
- [ ] Verify all API endpoints respond correctly
- [ ] Test OAuth flow (if possible locally)

## Deployment Options

### Option A: Vercel (Recommended)

#### Quick Deploy
- [ ] Push code to GitHub repository
- [ ] Connect repository to Vercel
- [ ] Configure environment variables in Vercel dashboard
- [ ] Deploy with `npm run deploy:vercel`

#### Manual Steps
1. **GitHub Setup**
   ```bash
   git init
   git add .
   git commit -m "Initial deployment"
   git branch -M main
   git remote add origin https://github.com/yourusername/shopify-store-sync.git
   git push -u origin main
   ```

2. **Vercel Dashboard**
   - Import GitHub repository
   - Set environment variables
   - Deploy automatically

3. **Domain Configuration**
   - [ ] Note your Vercel app URL (e.g., `https://your-app.vercel.app`)
   - [ ] Configure custom domain (optional)

### Option B: Netlify

- [ ] Connect GitHub repository to Netlify
- [ ] Configure build settings (uses `netlify.toml`)
- [ ] Set environment variables in Netlify dashboard
- [ ] Deploy with `npm run deploy:netlify`

### Option C: Railway

- [ ] Install Railway CLI: `npm install -g @railway/cli`
- [ ] Login: `railway login`
- [ ] Initialize: `railway init`
- [ ] Deploy: `railway up`
- [ ] Configure environment variables in Railway dashboard

## Post-Deployment Configuration

### 1. Update Shopify App Settings
- [ ] Update App URL in Shopify Partner Dashboard
- [ ] Update Allowed redirection URLs:
  - `https://your-domain.com/api/auth/shopify/callback`
  - `https://your-domain.com/api/auth/callback`
- [ ] Update `shopify.app.toml` with production URLs

### 2. Update Application Configuration
- [ ] Update `NEXTAUTH_URL` environment variable with production URL
- [ ] Update `next.config.ts` if needed
- [ ] Verify all API endpoints are accessible

### 3. Test Production Deployment
- [ ] Visit your production URL
- [ ] Test app installation flow
- [ ] Verify OAuth authentication works
- [ ] Test export functionality
- [ ] Test import functionality
- [ ] Check error handling

## Security Checklist

### Environment Security
- [ ] All sensitive data in environment variables
- [ ] No API keys committed to version control
- [ ] Secure random `NEXTAUTH_SECRET` generated
- [ ] HTTPS enabled for production

### Shopify Security
- [ ] Webhook signature verification implemented
- [ ] OAuth state parameter validation
- [ ] HMAC verification for requests
- [ ] Proper session management

### Application Security
- [ ] CORS headers configured correctly
- [ ] CSP headers for embedded app
- [ ] Rate limiting implemented
- [ ] Input validation on all endpoints

## Monitoring Setup

### Error Tracking
- [ ] Set up error monitoring (Sentry recommended)
- [ ] Configure logging for API endpoints
- [ ] Set up alerts for critical errors

### Performance Monitoring
- [ ] Enable Vercel Analytics (if using Vercel)
- [ ] Monitor API response times
- [ ] Track user engagement metrics

### Health Checks
- [ ] Implement health check endpoint
- [ ] Monitor uptime
- [ ] Set up status page (optional)

## Going Live

### Final Testing
- [ ] Test on development store first
- [ ] Verify all functionality works in production
- [ ] Test with real Shopify stores (if available)
- [ ] Load test API endpoints

### Launch
- [ ] Submit app for review (if making public)
- [ ] Update documentation with production URLs
- [ ] Announce to users/stakeholders
- [ ] Monitor for issues in first 24 hours

### Post-Launch
- [ ] Monitor error logs daily
- [ ] Collect user feedback
- [ ] Plan feature updates
- [ ] Regular security updates

## Troubleshooting Common Issues

### OAuth Issues
- **Problem**: Redirect URI mismatch
- **Solution**: Ensure URLs match exactly in Shopify Partner Dashboard

### API Issues
- **Problem**: 401 Unauthorized errors
- **Solution**: Verify API keys and access tokens are correct

### Embedded App Issues
- **Problem**: App not loading in Shopify admin
- **Solution**: Check CSP headers and X-Frame-Options

### Performance Issues
- **Problem**: Slow API responses
- **Solution**: Implement caching and optimize database queries

## Support Resources

- [Shopify App Development Docs](https://shopify.dev/docs/apps)
- [Next.js Deployment Guide](https://nextjs.org/docs/deployment)
- [Vercel Documentation](https://vercel.com/docs)
- [Netlify Documentation](https://docs.netlify.com/)

---

**✅ Ready to deploy your Shopify Store Sync app!**

Once deployed, your app will be available at your production URL and ready for Shopify store installations.
