# ⚠️ IMPORTANT: Render Dashboard Configuration

Since you're deploying via the Render Dashboard (not using render.yaml), you need to configure these settings **manually in the Render dashboard**:

## 🎯 Exact Settings for Render Dashboard

### Basic Settings:

```
Name: studysync-backend
Region: Oregon (US West)
Branch: main
Runtime: Node
```

### ⚠️ CRITICAL - Build & Deploy Settings:

```
Root Directory: (leave EMPTY - do not set this)

Build Command: cd server && npm install

Start Command: cd server && node index.js
```

### Environment Variables:

Click "Add Environment Variable" for each:

```
NODE_ENV = production

MONGODB_URI = mongodb+srv://gurjarrahul9111227474_db_user:Kd4hX1zTAI3guDZs@cluster0.ep5xkwa.mongodb.net/tandem-track-mate?retryWrites=true&w=majority&appName=Cluster0

JWT_SECRET = (generate a new secure secret - see below)

CLIENT_URL = (your frontend URL, or leave blank for now)
```

### Generate New JWT Secret:

Run this command in your terminal:

```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

Copy the output and paste it as the JWT_SECRET value.

## 🔄 After Saving Settings

1. Click "Create Web Service" or "Save Changes"
2. Render will automatically redeploy
3. Wait 2-3 minutes
4. Check the logs to ensure it starts successfully

## ✅ Verification

Your service should start with these log messages:

```
🚀 Server is running on port 10000
🎥 Video signaling server ready
```

Your API will be available at:

```
https://studysync-backend-XXXX.onrender.com
```

## 🧪 Test Your Deployment

```bash
# Replace with your actual Render URL
curl https://studysync-backend-XXXX.onrender.com/health
```

Expected response:

```json
{ "status": "OK", "message": "Tandem Track Mate API is running" }
```
