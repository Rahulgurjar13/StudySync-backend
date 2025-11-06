# 🚀 Render Deployment Checklist

## ✅ Pre-Deployment Checklist

### 1. Environment Variables Ready

Before deploying, make sure you have these values ready:

- [ ] **MongoDB URI**: Get from MongoDB Atlas
- [ ] **JWT Secret**: Generate a random secure string
- [ ] **Client URL**: Your frontend URL (or leave blank for now)

### 2. MongoDB Atlas Setup

- [ ] MongoDB Atlas account created
- [ ] Database cluster created
- [ ] Database user created with password
- [ ] Network Access: Allow connections from anywhere (`0.0.0.0/0`)
- [ ] Connection string copied

**Get MongoDB URI:**

```
mongodb+srv://<username>:<password>@<cluster>.mongodb.net/<database>?retryWrites=true&w=majority
```

### 3. Generate JWT Secret

Run this command to generate a secure JWT secret:

```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

---

## 📋 Deployment Steps on Render

### Step 1: Push Code to GitHub

```bash
# Make sure all changes are committed
git add .
git commit -m "Ready for Render deployment"
git push origin main
```

### Step 2: Create Web Service on Render

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository: `StudySync-backend`

### Step 3: Configure Service

Use these **EXACT** settings:

| Setting            | Value                                |
| ------------------ | ------------------------------------ |
| **Name**           | `studysync-backend` (or your choice) |
| **Region**         | Oregon (US West)                     |
| **Branch**         | `main`                               |
| **Root Directory** | `server` ⚠️ **IMPORTANT**            |
| **Runtime**        | Node                                 |
| **Build Command**  | `npm install`                        |
| **Start Command**  | `node index.js`                      |
| **Instance Type**  | Free                                 |

### Step 4: Add Environment Variables

Click **"Advanced"** and add:

#### Required Variables:

```
NODE_ENV = production
MONGODB_URI = mongodb+srv://username:password@cluster.mongodb.net/database
JWT_SECRET = (paste your generated secret here)
```

#### Optional Variables:

```
CLIENT_URL = https://your-frontend-url.com
```

### Step 5: Deploy

1. Click **"Create Web Service"**
2. Wait 3-5 minutes for deployment
3. Monitor the build logs

---

## 🧪 Testing Your Deployment

Once deployed, your URL will be: `https://studysync-backend.onrender.com`

### Test 1: Root Endpoint

```bash
curl https://studysync-backend.onrender.com/
```

Expected response:

```json
{
  "message": "Tandem Track Mate API Server",
  "version": "1.0.0",
  "status": "running",
  "endpoints": {...}
}
```

### Test 2: Health Check

```bash
curl https://studysync-backend.onrender.com/health
```

Expected response:

```json
{
  "status": "OK",
  "message": "Tandem Track Mate API is running"
}
```

### Test 3: Register User

```bash
curl -X POST https://studysync-backend.onrender.com/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "Test123!@#"
  }'
```

### Test 4: Login User

```bash
curl -X POST https://studysync-backend.onrender.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123!@#"
  }'
```

---

## 🔧 Common Issues & Solutions

### Issue 1: "Cannot find package.json"

**Solution:** Make sure **Root Directory** is set to `server`

### Issue 2: "MongoDB connection failed"

**Solutions:**

- Verify MongoDB URI is correct
- Check username/password in connection string
- Ensure IP whitelist includes `0.0.0.0/0` in MongoDB Atlas
- Verify database user has read/write permissions

### Issue 3: "Module not found" errors

**Solution:** Make sure all dependencies are in `dependencies` (not `devDependencies`)

```bash
npm install --save <package-name>
```

### Issue 4: Service spins down after 15 minutes

**This is normal on free tier:**

- Free services sleep after 15 minutes of inactivity
- Wake up on next request (takes 30-60 seconds)
- Upgrade to paid plan to keep service always active

### Issue 5: CORS errors

**Solution:** Add your frontend URL to environment variables:

```
CLIENT_URL=https://your-frontend.onrender.com
```

---

## 📊 Monitoring

### View Logs

1. Go to Render Dashboard
2. Click your service
3. Click **"Logs"** tab
4. View real-time logs

### Metrics

1. Click **"Metrics"** tab
2. View:
   - CPU usage
   - Memory usage
   - Request count
   - Response times

### Manual Deploy

If you need to redeploy:

1. Go to service dashboard
2. Click **"Manual Deploy"**
3. Select **"Deploy latest commit"** or **"Clear build cache & deploy"**

---

## 🔄 Updating Your App

### Auto-Deploy (Recommended)

Render automatically deploys when you push to GitHub:

```bash
git add .
git commit -m "Update feature"
git push origin main
```

Render will detect the push and redeploy automatically!

### Manual Deploy

1. Push changes to GitHub
2. Go to Render Dashboard
3. Click "Manual Deploy" → "Deploy latest commit"

---

## 🎯 Next Steps

- [ ] Deploy frontend (Render/Vercel/Netlify)
- [ ] Update `CLIENT_URL` with frontend URL
- [ ] Update frontend code with backend URL
- [ ] Test full authentication flow
- [ ] Test WebRTC signaling with Socket.IO
- [ ] Set up custom domain (optional)
- [ ] Enable monitoring/alerts
- [ ] Consider upgrading to paid tier for production

---

## 📝 Important Notes

### Free Tier Limitations:

- ✅ 750 hours/month
- ✅ Auto-deploy from GitHub
- ⚠️ Spins down after 15 min inactivity
- ⚠️ Cold start: 30-60 seconds
- ⚠️ Limited to 512 MB RAM

### For Production:

- Upgrade to Starter plan ($7/month)
- Keeps service always running
- More resources
- Better performance

---

## 🆘 Support

**Render Documentation:** https://render.com/docs
**MongoDB Atlas Docs:** https://docs.atlas.mongodb.com/
**Project Issues:** https://github.com/Rahulgurjar13/StudySync-backend/issues

---

## ✅ Deployment Complete!

Your backend is now live at:

```
https://your-service-name.onrender.com
```

Save this URL for your frontend configuration!

**Example frontend .env:**

```
VITE_API_URL=https://studysync-backend.onrender.com
VITE_SOCKET_URL=https://studysync-backend.onrender.com
```
