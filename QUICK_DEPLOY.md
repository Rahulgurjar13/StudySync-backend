# 🚀 Quick Deploy Guide - Copy & Paste These Settings

## Step 1: Go to Render Dashboard
👉 https://dashboard.render.com/

## Step 2: Click "New +" → "Web Service"

## Step 3: Connect Repository
- Select: **StudySync-backend**
- Click "Connect"

## Step 4: Configure Settings (Copy these EXACTLY)

### Name:
```
studysync-backend
```

### Region:
```
Oregon (US West)
```

### Branch:
```
main
```

### Root Directory:
```
(leave this EMPTY - do not type anything)
```

### Runtime:
```
Node
```

### Build Command:
```
cd server && npm install
```

### Start Command:
```
cd server && node index.js
```

### Instance Type:
```
Free
```

## Step 5: Add Environment Variables

Click "Add Environment Variable" button and add these ONE BY ONE:

### Variable 1:
```
Key: NODE_ENV
Value: production
```

### Variable 2:
```
Key: MONGODB_URI
Value: mongodb+srv://gurjarrahul9111227474_db_user:Kd4hX1zTAI3guDZs@cluster0.ep5xkwa.mongodb.net/tandem-track-mate?retryWrites=true&w=majority&appName=Cluster0
```

### Variable 3 (Generate a NEW secret):
First, run this in your terminal:
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

Then add:
```
Key: JWT_SECRET
Value: (paste the generated secret here)
```

### Variable 4 (Optional - can add later):
```
Key: CLIENT_URL
Value: (your frontend URL when you have it)
```

## Step 6: Click "Create Web Service"

Wait 3-5 minutes for deployment to complete.

## Step 7: Test Your API

Your URL will be something like:
```
https://studysync-backend.onrender.com
```

Test it:
```bash
# Health check
curl https://YOUR-URL.onrender.com/health

# Should return:
# {"status":"OK","message":"Tandem Track Mate API is running"}
```

## ✅ Success Indicators

In the Render logs, you should see:
```
🚀 Server is running on port 10000
🎥 Video signaling server ready
```

## 🎯 Your Backend URL

Save this URL for your frontend:
```
https://studysync-backend.onrender.com
```

Use it in your frontend `.env`:
```
VITE_API_URL=https://studysync-backend.onrender.com
VITE_SOCKET_URL=https://studysync-backend.onrender.com
```

## 🔧 If Deployment Fails

1. Check the "Logs" tab in Render dashboard
2. Make sure:
   - Root Directory is EMPTY
   - Build Command is: `cd server && npm install`
   - Start Command is: `cd server && node index.js`
   - All environment variables are added correctly
3. Try "Manual Deploy" → "Clear build cache & deploy"

---

**That's it! Your backend should now be live! 🎉**
