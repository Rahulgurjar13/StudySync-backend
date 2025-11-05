# Tandem Track Mate - Backend

Express.js backend server for Tandem Track Mate study collaboration platform with MongoDB and Socket.IO for real-time features.

## Features

- 🔐 User Authentication (JWT)
- 📝 Task Management
- 🤝 Study Partnerships
- 🎯 Focus Sessions with Pomodoro
- 📊 Points & Gamification System
- 🔄 Real-time WebRTC Signaling
- 📚 Shared Resources

## Tech Stack

- **Runtime:** Node.js
- **Framework:** Express.js
- **Database:** MongoDB (Mongoose)
- **Real-time:** Socket.IO
- **Authentication:** JWT & bcryptjs
- **Validation:** express-validator

## Getting Started

### Prerequisites

- Node.js (v18 or higher)
- MongoDB Atlas account or local MongoDB
- npm or yarn

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd backned-studysyc
```

2. Install dependencies:
```bash
cd server
npm install
```

3. Create `.env` file in the `server` directory:
```bash
cp .env.example .env
```

4. Update the `.env` file with your credentials:
```env
PORT=3001
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key
NODE_ENV=development
CLIENT_URL=http://localhost:5173
```

### Running the Server

Development mode with auto-reload:
```bash
npm run dev
```

Production mode:
```bash
npm start
```

The server will start on `http://localhost:3001`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user

### Tasks
- `GET /api/tasks` - Get all tasks
- `POST /api/tasks` - Create task
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task

### Partnerships
- `GET /api/partnerships` - Get partnerships
- `POST /api/partnerships` - Create partnership
- `PUT /api/partnerships/:id` - Update partnership

### Focus Sessions
- `POST /api/focus/start` - Start focus session
- `POST /api/focus/end` - End focus session
- `GET /api/focus/stats` - Get focus statistics

### Points
- `GET /api/points` - Get user points
- `GET /api/points/history` - Get points history

### Resources
- `GET /api/resources` - Get shared resources
- `POST /api/resources` - Share resource

## Deployment on Render

### Option 1: Using Render Dashboard

1. **Push your code to GitHub:**
   ```bash
   git add .
   git commit -m "Prepare for Render deployment"
   git push origin main
   ```

2. **Deploy on Render:**
   - Go to [Render Dashboard](https://dashboard.render.com/)
   - Click "New +" and select "Web Service"
   - Connect your GitHub repository
   - Configure:
     - **Name:** tandem-track-mate-backend
     - **Region:** Oregon (US West)
     - **Branch:** main
     - **Root Directory:** (leave empty)
     - **Runtime:** Node
     - **Build Command:** `cd server && npm install`
     - **Start Command:** `cd server && npm start`

3. **Add Environment Variables:**
   - `NODE_ENV` = `production`
   - `MONGODB_URI` = Your MongoDB connection string
   - `JWT_SECRET` = Generate a secure random string
   - `CLIENT_URL` = Your frontend URL (e.g., https://your-frontend.onrender.com)
   - `PORT` = `10000` (Render's default)

### Option 2: Using render.yaml (Infrastructure as Code)

The `render.yaml` file is already configured. Just:
1. Push to GitHub
2. Connect the repository in Render
3. Add the required environment variables in Render dashboard

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| PORT | Server port | No (defaults to 3001) |
| MONGODB_URI | MongoDB connection string | Yes |
| JWT_SECRET | Secret key for JWT tokens | Yes |
| NODE_ENV | Environment (development/production) | Yes |
| CLIENT_URL | Frontend URL for CORS | Yes |

## Project Structure

```
server/
├── config/
│   └── database.js          # MongoDB connection
├── middleware/
│   └── auth.js              # JWT authentication middleware
├── models/
│   ├── User.js
│   ├── Task.js
│   ├── Partnership.js
│   ├── FocusSession.js
│   └── ...
├── routes/
│   ├── auth.js
│   ├── tasks.js
│   ├── partnerships.js
│   └── ...
├── utils/
│   └── pointSystem.js       # Gamification logic
├── index.js                 # Main server file
└── package.json
```

## License

ISC

## Support

For issues or questions, please open an issue in the repository.
