# 🔐 Environment Variables for Render Deployment

## ⚠️ IMPORTANT: Add these to Render Dashboard

When deploying on Render, you need to manually add these environment variables in the Render dashboard.

**Where to add them:**
1. Go to your service in Render dashboard
2. Click on "Environment" tab (or find it during initial setup)
3. Add each variable below

---

## 📋 Copy & Paste These Values

### Variable 1: NODE_ENV
```
Key: NODE_ENV
Value: production
```

### Variable 2: MONGODB_URI
```
Key: MONGODB_URI
Value: mongodb+srv://gurjarrahul9111227474_db_user:Kd4hX1zTAI3guDZs@cluster0.ep5xkwa.mongodb.net/tandem-track-mate?retryWrites=true&w=majority&appName=Cluster0
```

### Variable 3: JWT_SECRET
**⚠️ GENERATE A NEW ONE FOR PRODUCTION!**

Run this command in your terminal:
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

Then add:
```
Key: JWT_SECRET
Value: (paste the generated secret here - should be a long random string)
```

### Variable 4: CLIENT_URL
```
Key: CLIENT_URL
Value: https://study-sync11.vercel.app
```

### Variable 5: PORT (Optional - Render sets this automatically)
```
Key: PORT
Value: 10000
```
*Note: Render usually sets PORT automatically, so you can skip this one.*

---

## ✅ Your Local .env File (for reference)

Your current `.env` file in `/server/.env`:
```
PORT=3001
MONGODB_URI=mongodb+srv://gurjarrahul9111227474_db_user:Kd4hX1zTAI3guDZs@cluster0.ep5xkwa.mongodb.net/tandem-track-mate?retryWrites=true&w=majority&appName=Cluster0
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
NODE_ENV=development
CLIENT_URL=https://study-sync11.vercel.app
```

**Note:** This `.env` file is **NOT** pushed to GitHub (it's in `.gitignore`), so you must manually add these values to Render.

---

## 🔒 Security Notes

1. ✅ `.env` file is in `.gitignore` - it won't be pushed to GitHub
2. ✅ Generate a **new, strong** JWT_SECRET for production (don't use the default one)
3. ✅ MongoDB connection string is from your Atlas cluster
4. ✅ CORS is configured to allow your Vercel frontend

---

## 📸 Screenshot Guide

When adding environment variables in Render:

1. Each variable should be added separately
2. Click "Add Environment Variable" button
3. Enter the **Key** name (e.g., `NODE_ENV`)
4. Enter the **Value** (e.g., `production`)
5. Click "Save" or continue adding more
6. After all are added, deploy/redeploy your service

---

## 🧪 After Deployment - Verify

Once deployed, test that your backend can talk to your frontend:

1. Your backend URL: `https://studysync-backend.onrender.com`
2. Your frontend URL: `https://study-sync11.vercel.app`

Test CORS:
```bash
curl -H "Origin: https://study-sync11.vercel.app" \
     -H "Access-Control-Request-Method: POST" \
     -H "Access-Control-Request-Headers: Content-Type" \
     -X OPTIONS \
     https://studysync-backend.onrender.com/api/auth/login -v
```

Should return headers including:
```
Access-Control-Allow-Origin: https://study-sync11.vercel.app
Access-Control-Allow-Credentials: true
```

---

## ✅ Checklist

Before deploying, make sure:

- [ ] All 4 environment variables added to Render
- [ ] Generated a NEW JWT_SECRET (not the default one)
- [ ] MongoDB Atlas allows connections from anywhere (0.0.0.0/0)
- [ ] Root Directory set to `server` in Render
- [ ] Build Command: `npm install`
- [ ] Start Command: `node index.js`
- [ ] Code pushed to GitHub
- [ ] Frontend updated with backend URL

---

**You're all set! Deploy now! 🚀**
