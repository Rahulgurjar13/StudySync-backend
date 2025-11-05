# 🚀 Deployment Guide - Tandem Track Mate Backend

## Step-by-Step Deployment to Render

### Step 1: Create GitHub Repository

1. **Go to GitHub** and create a new repository:
   - Go to: https://github.com/new
   - Repository name: `tandem-track-mate-backend` (or your preferred name)
   - Description: "Express backend for Tandem Track Mate study collaboration platform"
   - Set to **Public** or **Private** (your choice)
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
   - Click "Create repository"

### Step 2: Push Code to GitHub

Run these commands in your terminal:

```bash
# Navigate to your project directory
cd "/Users/rahulgurjar/Desktop/backned studysyc"

# Add your GitHub repository as remote (replace YOUR_USERNAME and YOUR_REPO_NAME)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push your code to GitHub
git branch -M main
git push -u origin main
```

**Example:**
```bash
git remote add origin https://github.com/yourusername/tandem-track-mate-backend.git
git branch -M main
git push -u origin main
```

### Step 3: Deploy on Render

#### 3.1 Create Render Account
- Go to https://render.com/
- Sign up with your GitHub account (recommended for easier deployment)

#### 3.2 Create New Web Service

1. **Click "New +"** in the top right corner
2. Select **"Web Service"**
3. **Connect your GitHub repository:**
   - Click "Connect account" if not connected
   - Find and select your repository: `tandem-track-mate-backend`
   - Click "Connect"

#### 3.3 Configure the Web Service

Fill in the following settings:

| Field | Value |
|-------|-------|
| **Name** | `tandem-track-mate-backend` (or your preferred name) |
| **Region** | Oregon (US West) - or closest to you |
| **Branch** | `main` |
| **Root Directory** | (leave empty) |
| **Runtime** | `Node` |
| **Build Command** | `cd server && npm install` |
| **Start Command** | `cd server && npm start` |
| **Instance Type** | `Free` |

#### 3.4 Add Environment Variables

Click **"Advanced"** and add these environment variables:

| Key | Value | Notes |
|-----|-------|-------|
| `NODE_ENV` | `production` | Required |
| `MONGODB_URI` | Your MongoDB connection string | **Get from MongoDB Atlas** |
| `JWT_SECRET` | Random secure string | **Generate a strong secret** |
| `CLIENT_URL` | Your frontend URL | e.g., `https://your-frontend.onrender.com` |
| `PORT` | `10000` | Render default (optional) |

**How to get MongoDB URI:**
1. Go to MongoDB Atlas: https://cloud.mongodb.com/
2. Click "Connect" on your cluster
3. Choose "Connect your application"
4. Copy the connection string
5. Replace `<password>` with your actual password

**Generate JWT_SECRET:**
Run this in terminal to generate a secure secret:
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

#### 3.5 Deploy

1. Click **"Create Web Service"**
2. Render will automatically:
   - Clone your repository
   - Install dependencies
   - Start your server
3. Wait 2-5 minutes for deployment to complete

#### 3.6 Get Your Backend URL

Once deployed, you'll get a URL like:
```
https://tandem-track-mate-backend.onrender.com
```

**Test your deployment:**
```bash
# Health check
curl https://your-backend-url.onrender.com/health

# Should return: {"status":"ok","timestamp":"..."}
```

---

## Important Notes

### ⚠️ Free Tier Limitations

Render's free tier:
- **Spins down after 15 minutes** of inactivity
- **Takes 30-60 seconds** to wake up on first request
- 750 hours/month (sufficient for testing)

**Solution for production:** Upgrade to paid tier ($7/month)

### 🔒 Security Checklist

- ✅ `.env` file is **NOT** pushed to GitHub (in `.gitignore`)
- ✅ Use **strong JWT_SECRET** (64+ characters)
- ✅ MongoDB user has **limited permissions**
- ✅ CORS is configured for your frontend only
- ✅ Environment variables set in Render dashboard

### 🔄 Updating Your Deployment

Whenever you make changes:

```bash
# Stage and commit changes
git add .
git commit -m "Your commit message"

# Push to GitHub
git push origin main
```

Render will **automatically redeploy** when you push to the main branch!

---

## Testing Your Backend

### 1. Health Check
```bash
curl https://your-backend-url.onrender.com/health
```

### 2. Register a User
```bash
curl -X POST https://your-backend-url.onrender.com/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "Test123!@#"
  }'
```

### 3. Login
```bash
curl -X POST https://your-backend-url.onrender.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123!@#"
  }'
```

---

## Troubleshooting

### Issue: Build Failed
- Check build logs in Render dashboard
- Ensure `package.json` has all dependencies
- Verify Node version compatibility

### Issue: Runtime Error
- Check runtime logs in Render dashboard
- Verify all environment variables are set
- Test MongoDB connection string locally

### Issue: Cannot Connect to MongoDB
- Whitelist Render's IP: `0.0.0.0/0` in MongoDB Atlas
- Verify connection string format
- Check MongoDB user permissions

### Issue: CORS Errors
- Add your frontend URL to `CLIENT_URL` env variable
- Check CORS configuration in `index.js`

---

## Monitoring & Logs

### View Logs
1. Go to Render dashboard
2. Click your service
3. Click "Logs" tab
4. See real-time server logs

### Restart Service
1. Go to Render dashboard
2. Click "Manual Deploy" → "Clear build cache & deploy"

---

## Next Steps

1. ✅ Deploy frontend to Render/Vercel/Netlify
2. ✅ Update `CLIENT_URL` in backend env variables
3. ✅ Update backend URL in frontend code
4. ✅ Test end-to-end functionality
5. ✅ Set up custom domain (optional)
6. ✅ Monitor performance and errors

---

## Support & Resources

- **Render Docs:** https://render.com/docs
- **MongoDB Atlas:** https://docs.atlas.mongodb.com/
- **Project Repository:** Your GitHub repo URL

---

## Quick Commands Reference

```bash
# Configure Git (one-time setup)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Check repository status
git status

# Add all changes
git add .

# Commit changes
git commit -m "Your message"

# Push to GitHub
git push origin main

# View remote URL
git remote -v

# Generate JWT secret
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

---

**🎉 You're all set! Your backend is now deployed and ready to use!**
