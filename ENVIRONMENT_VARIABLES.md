# 🔐 Environment Variables Configuration

## Backend (Render) - Environment Variables

Go to your Render dashboard → Your service → Environment tab

### Add These Variables:

```env
NODE_ENV=production

MONGODB_URI=mongodb+srv://gurjarrahul9111227474_db_user:Kd4hX1zTAI3guDZs@cluster0.ep5xkwa.mongodb.net/tandem-track-mate?retryWrites=true&w=majority&appName=Cluster0

JWT_SECRET=c1ec853d41a0f7bd5dc45aff7c1b7550d60bd1dd4383be9a53f9dbfbde7a81dea36c860bd5a44156fd7462a83142e21155cd18ec3d90061e55a6bf00b5637eba

CLIENT_URL=https://study-sync11.vercel.app
```

### Important Notes:

- ✅ Make sure `CLIENT_URL` is set to your Vercel frontend URL
- ✅ No trailing slash in `CLIENT_URL`
- ✅ After adding/updating, click "Save Changes"
- ✅ Render will automatically redeploy

---

## Frontend (Vercel) - Environment Variables

Go to Vercel Dashboard → Your Project → Settings → Environment Variables

### Add These Variables:

```env
VITE_API_URL=https://studysync-backend-2.onrender.com

VITE_SOCKET_URL=https://studysync-backend-2.onrender.com
```

### Steps to Add in Vercel:

1. Go to: https://vercel.com/dashboard
2. Select your project: `study-sync11`
3. Click **Settings**
4. Click **Environment Variables** (left sidebar)
5. Add each variable:

   - **Name:** `VITE_API_URL`
   - **Value:** `https://studysync-backend-2.onrender.com`
   - **Environments:** Select all (Production, Preview, Development)
   - Click **Save**

   - **Name:** `VITE_SOCKET_URL`
   - **Value:** `https://studysync-backend-2.onrender.com`
   - **Environments:** Select all (Production, Preview, Development)
   - Click **Save**

6. **Redeploy** your frontend:
   - Go to **Deployments** tab
   - Click the three dots on the latest deployment
   - Click **Redeploy**
   - OR push a new commit to trigger auto-deployment

---

## Frontend Code - Socket.IO Connection

### Check Your Socket.IO Setup

In your frontend code (likely in `src/socket.js` or `src/utils/socket.js`), make sure it looks like this:

```javascript
import { io } from "socket.io-client";

// Use environment variable or fallback to localhost for development
const SOCKET_URL = import.meta.env.VITE_SOCKET_URL || "http://localhost:3001";

console.log("🔌 Connecting to Socket.IO:", SOCKET_URL);

const socket = io(SOCKET_URL, {
  // Use WebSocket first, fallback to polling
  transports: ["websocket", "polling"],

  // Send cookies for authentication
  withCredentials: true,

  // Auto-reconnect settings
  reconnection: true,
  reconnectionAttempts: 5,
  reconnectionDelay: 1000,
  reconnectionDelayMax: 5000,

  // Timeout settings
  timeout: 20000,

  // Enable automatic upgrade from polling to WebSocket
  upgrade: true,

  // Force new connection
  forceNew: false,
});

// Connection event handlers
socket.on("connect", () => {
  console.log("✅ Connected to Socket.IO server:", socket.id);
});

socket.on("connect_error", (error) => {
  console.error("❌ Socket.IO connection error:", error.message);
});

socket.on("disconnect", (reason) => {
  console.log("⚠️ Disconnected from Socket.IO:", reason);
});

socket.on("reconnect", (attemptNumber) => {
  console.log("🔄 Reconnected to Socket.IO after", attemptNumber, "attempts");
});

export default socket;
```

### ⚠️ Important: Remove Namespace if Present

If your code looks like this:

```javascript
// ❌ WRONG - Has namespace
io("https://studysync-backend-2.onrender.com/video");
io("https://studysync-backend-2.onrender.com/call");
```

Change to:

```javascript
// ✅ CORRECT - No namespace
io("https://studysync-backend-2.onrender.com");
```

### API Calls Configuration

Make sure your API calls also use the environment variable:

```javascript
const API_URL = import.meta.env.VITE_API_URL || "http://localhost:3001";

// Example: Login API call
const login = async (email, password) => {
  const response = await fetch(`${API_URL}/api/auth/login`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    credentials: "include", // Important for cookies
    body: JSON.stringify({ email, password }),
  });

  return response.json();
};
```

---

## Testing the Connection

### 1. Test Backend Health

```bash
curl https://studysync-backend-2.onrender.com/health
```

Expected:

```json
{ "status": "OK", "message": "Tandem Track Mate API is running" }
```

### 2. Test Socket.IO Status

```bash
curl https://studysync-backend-2.onrender.com/socket-status
```

Expected:

```json
{
  "socketio": "running",
  "activeConnections": 0,
  "activeRooms": 0,
  "connectedUsers": 0
}
```

### 3. Test Frontend

1. Open browser DevTools (F12)
2. Go to Console tab
3. Visit: https://study-sync11.vercel.app
4. Look for:
   ```
   🔌 Connecting to Socket.IO: https://studysync-backend-2.onrender.com
   ✅ Connected to Socket.IO server: [socket-id]
   ```

---

## Troubleshooting

### Issue: Environment variables not updating

**Solution:** After adding variables in Vercel:

1. Go to Deployments tab
2. Trigger a new deployment (push a commit or redeploy manually)

### Issue: Still connecting to localhost

**Solution:**

1. Check if environment variables are added correctly in Vercel
2. Make sure variable names start with `VITE_` prefix
3. Redeploy frontend

### Issue: CORS errors

**Solution:**

1. Make sure `CLIENT_URL` in Render backend is set to `https://study-sync11.vercel.app`
2. No trailing slash
3. Redeploy backend

### Issue: Socket.IO connection fails

**Solution:**

1. Check browser console for error details
2. Make sure using `https://` not `http://`
3. Remove any custom namespace from Socket.IO connection
4. Check if `withCredentials: true` is set

---

## Quick Checklist

### Backend (Render)

- [ ] `NODE_ENV` = `production`
- [ ] `MONGODB_URI` = (your MongoDB connection string)
- [ ] `JWT_SECRET` = (secure random string)
- [ ] `CLIENT_URL` = `https://study-sync11.vercel.app` (no trailing slash)
- [ ] Service is deployed and running
- [ ] Health check passes: `/health`
- [ ] Socket status check passes: `/socket-status`

### Frontend (Vercel)

- [ ] `VITE_API_URL` = `https://studysync-backend-2.onrender.com`
- [ ] `VITE_SOCKET_URL` = `https://studysync-backend-2.onrender.com`
- [ ] Variables are set for all environments (Production, Preview, Development)
- [ ] Redeployed after adding variables
- [ ] Socket.IO connection has no namespace
- [ ] Using `withCredentials: true`

---

## Summary

### Backend URL:

```
https://studysync-backend-2.onrender.com
```

### Frontend URL:

```
https://study-sync11.vercel.app
```

### What's Configured:

✅ CORS allows your frontend domain
✅ Socket.IO configured for WebRTC
✅ MongoDB connected
✅ JWT authentication ready
✅ All API endpoints working

### Next Steps:

1. Add environment variables in Vercel
2. Fix Socket.IO connection code in frontend (remove namespace if present)
3. Redeploy frontend
4. Test the connection!

---

**Need help with the frontend Socket.IO code? Share the file and I'll fix it for you!** 🚀
