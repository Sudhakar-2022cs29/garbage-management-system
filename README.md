# 🗑️ Smart Garbage Management System

A complete web application for efficient garbage collection management with user complaints, admin control, and worker task assignment.

## 📋 Project Overview

This system allows users to report garbage issues in their locality, enables admins to assign complaints to workers, and provides workers with task management features. It also includes smart bin status tracking and analytics dashboards.

## ✨ Features

### User Features
- User registration and login
- Raise garbage complaints with location, description, and image upload
- View complaint status and history
- Track complaint assignment and completion
- View smart bin status across the city
- Dashboard with complaint statistics

### Admin Features
- Admin login and dashboard
- View all complaints with filtering
- Assign complaints to available workers
- Monitor worker performance
- Manage smart bin status
- System analytics (complaint resolution rate, etc.)
- View worker performance metrics

### Worker Features
- Worker login and personal dashboard
- View assigned tasks
- Update task status (Pending → In Progress → Completed)
- Upload completion proof images
- Track completed tasks
- Daily work statistics

### Smart Features
- Smart bin status monitoring (Empty/Half/Full)
- Real-time dashboard updates
- Complaint analytics
- Worker performance tracking
- Charts and analytics (Chart.js)

## 🛠️ Tech Stack

- **Frontend:** HTML5, CSS3, Vanilla JavaScript (ES6+)
- **Backend:** Node.js with Express.js
- **Database:** MySQL
- **Charts:** Chart.js
- **Other:** Multer (file upload), bcryptjs (password hashing), express-session (authentication)

## 📁 Project Structure

```
garbage-management/
├── backend/
│   ├── config/
│   │   └── db.js                 # Database configuration
│   ├── middleware/
│   │   ├── auth.js               # Authentication middleware
│   │   ├── validators.js         # Input validation
│   │   └── errorHandler.js       # Error handling
│   ├── routes/
│   │   ├── authRoutes.js         # Auth endpoints
│   │   ├── userRoutes.js         # User endpoints
│   │   ├── adminRoutes.js        # Admin endpoints
│   │   └── workerRoutes.js       # Worker endpoints
│   ├── controllers/              # Business logic
│   ├── services/                 # Database operations
│   └── server.js                 # Main server file
├── public/
│   ├── index.html                # Login page
│   ├── dashboard.html            # User dashboard
│   ├── admin-dashboard.html      # Admin panel
│   ├── worker-dashboard.html     # Worker dashboard
│   ├── css/
│   │   ├── style.css             # Global styles
│   │   ├── auth.css              # Auth page styles
│   │   ├── dashboard.css         # Dashboard styles
│   │   ├── admin-dashboard.css   # Admin styles
│   │   └── worker-dashboard.css  # Worker styles
│   └── js/
│       ├── auth.js               # Auth page logic
│       ├── user-dashboard.js     # User dashboard logic
│       ├── admin-dashboard.js    # Admin dashboard logic
│       └── worker-dashboard.js   # Worker dashboard logic
├── uploads/                      # Uploaded images
├── schema.sql                    # Database schema with dummy data
├── package.json                  # Node.js dependencies
├── .env                          # Environment configuration
├── .gitignore                    # Git ignore file
└── README.md                     # This file
```

## 🚀 Quick Start

### Prerequisites
- Node.js (v14 or higher)
- MySQL Server
- npm (comes with Node.js)

### Step 1: Install Dependencies

```bash
npm install
```

This will install:
- express (web framework)
- mysql2 (database driver)
- express-session (session management)
- bcryptjs (password hashing)
- multer (file uploads)
- dotenv (environment variables)
- express-validator (input validation)
- cors (cross-origin requests)

### Step 2: Setup Database

1. **Create MySQL Database:**
   ```bash
   mysql -u root -p < schema.sql
   ```

   Or open MySQL client and run:
   ```sql
   CREATE DATABASE IF NOT EXISTS smart_garbage_db;
   USE smart_garbage_db;
   -- Then run all commands from schema.sql
   ```

2. **Database Tables Created:**
   - `Users` - User accounts (regular users, admins, workers)
   - `Complaints` - Garbage complaints
   - `Workers` - Worker profiles
   - `Assignments` - Task assignments to workers
   - `SmartBins` - Smart bin locations and status

### Step 3: Configure Environment Variables

Update `.env` file with your MySQL credentials:

```env
# Database Configuration
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=smart_garbage_db
DB_PORT=3306

# Server Configuration
PORT=3000
NODE_ENV=development

# Sessions
SESSION_SECRET=your_secret_key_change_this

# File Upload
MAX_FILE_SIZE=5242880
UPLOAD_FOLDER=uploads
```

### Step 4: Start the Server

```bash
npm start
```

Or for development with auto-reload:
```bash
npm run dev
```

Server will start at: **http://localhost:3000**

## 📝 Demo Credentials

Use these credentials to test different roles:

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@garbage.com | admin123 |
| User | user1@gmail.com | user123 |
| User | user2@gmail.com | user123 |
| Worker | worker1@garbage.com | worker123 |
| Worker | worker2@garbage.com | worker123 |

**Note:** The passwords are hashed in the database. To add custom users, register through the registration form.

## 🗺️ Routes Guide

### Authentication Endpoints
```
POST   /api/auth/register    - User registration
POST   /api/auth/login       - User login
POST   /api/auth/logout      - User logout
GET    /api/auth/me          - Get current user info
```

### User Endpoints
```
POST   /api/user/complaint           - Create new complaint
GET    /api/user/complaints          - Get user's complaints
GET    /api/user/complaint/:id       - Get complaint details
GET    /api/user/dashboard/stats     - Get dashboard statistics
```

### Admin Endpoints
```
GET    /api/admin/complaints        - Get all complaints
GET    /api/admin/complaint/:id     - Get complaint details
GET    /api/admin/workers           - Get all workers
POST   /api/admin/assign            - Assign complaint to worker
GET    /api/admin/dashboard/stats   - Get admin statistics
GET    /api/admin/smart-bins        - Get smart bin status
PUT    /api/admin/smart-bin/:id     - Update bin status
```

### Worker Endpoints
```
GET    /api/worker/tasks                    - Get assigned tasks
GET    /api/worker/task/:assignmentId       - Get task details
PUT    /api/worker/task/:assignmentId       - Update task status
GET    /api/worker/dashboard/stats          - Get worker statistics
```

## 📋 Database Schema

### Users Table
```sql
id (PRIMARY KEY)
name VARCHAR(100)
email VARCHAR(100) UNIQUE
password VARCHAR(255)
role ENUM('user', 'admin', 'worker')
created_at TIMESTAMP
```

### Complaints Table
```sql
id (PRIMARY KEY)
user_id (FOREIGN KEY → Users)
location VARCHAR(255)
description TEXT
image VARCHAR(255)
status ENUM('Pending', 'Assigned', 'Completed')
created_at TIMESTAMP
```

### Workers Table
```sql
id (PRIMARY KEY)
user_id (FOREIGN KEY → Users)
name VARCHAR(100)
phone VARCHAR(20)
area VARCHAR(100)
created_at TIMESTAMP
```

### Assignments Table
```sql
id (PRIMARY KEY)
complaint_id (FOREIGN KEY → Complaints)
worker_id (FOREIGN KEY → Workers)
status ENUM('Assigned', 'In Progress', 'Completed')
assigned_at TIMESTAMP
completed_at TIMESTAMP (nullable)
proof_image VARCHAR(255)
```

### SmartBins Table
```sql
id (PRIMARY KEY)
location VARCHAR(255)
status ENUM('Empty', 'Half', 'Full')
last_updated TIMESTAMP
```

## 🎨 UI Features

### Login Page
- Beautiful gradient background
- Toggle between login and register forms
- Input validation
- Demo credentials display
- Error handling

### User Dashboard
- Overview with complaint statistics
- Complaint submission form with image upload
- Complaints list with filtering
- Complaint detail modal
- Smart bin status view
- Chart visualization

### Admin Dashboard
- System overview with 6 statistics
- Complaint management table
- Worker management
- Smart bin control
- Performance analytics with charts
- Complaint assignment modal

### Worker Dashboard
- Personal task overview
- Assigned tasks list
- Task details with complaint images
- Status update functionality
- Proof image upload on completion
- Completed tasks history
- Performance chart

## 🔐 Security Features

- **Password Hashing:** bcryptjs with 10 salt rounds
- **Session Management:** Express-session with secure cookies
- **Input Validation:** express-validator for all inputs
- **SQL Injection Prevention:** Prepared statements (mysql2/promise)
- **CORS:** Configured for frontend-backend communication
- **File Upload:** Restricted to image files only, max 5MB
- **Role-Based Access Control:** Middleware for protecting routes

## 📸 Image Upload

- Supported formats: JPG, PNG, GIF
- Maximum file size: 5MB
- Storage location: `/uploads/` directory
- File naming: Auto-generated timestamps to prevent conflicts
- Access: Direct URL access to uploaded files

## 📊 Analytics

- **User Dashboard:** Complaint status distribution chart
- **Admin Dashboard:** 
  - Complaint status pie chart
  - Worker performance bar chart
  - System analytics (resolution rate, efficiency)
- **Worker Dashboard:** Task status distribution chart

All charts use Chart.js for interactive visualization.

## 🧪 Testing Workflow

### 1. Test User Registration & Login
```
1. Go to http://localhost:3000
2. Click "Register here"
3. Fill in registration form
4. Login with new credentials
```

### 2. Test Complaint Creation
```
1. Login as user
2. Click "Raise Complaint"
3. Fill in location and description
4. Upload image (optional)
5. Submit and view in "My Complaints"
```

### 3. Test Admin Assignment
```
1. Login as admin
2. Go to "All Complaints"
3. Click "Assign" on pending complaint
4. Select worker and assign
5. View in "All Complaints" with "Assigned" status
```

### 4. Test Worker Task Update
```
1. Login as worker
2. View assigned tasks
3. Click "Update Status"
4. Change to "In Progress" or "Completed"
5. On completion, upload proof image
6. View in "Completed Tasks"
```

## 🛠️ Troubleshooting

### Database Connection Error
```
Error: connect ECONNREFUSED 127.0.0.1:3306

Solution: 
1. Check MySQL is running
2. Verify credentials in .env
3. Ensure database is created
```

### Port Already in Use
```
Error: Port 3000 is already in use

Solution:
1. Change PORT in .env to another port (3001, 3002, etc.)
2. Or kill process: lsof -i :3000 | kill -9 <PID>
```

### File Upload Not Working
```
Solution:
1. Create 'uploads' folder if missing
2. Check file permissions
3. Ensure max file size in nginx/server allows 5MB
```

### Session Not Persisting
```
Solution:
1. Clear browser cookies
2. Check SESSION_SECRET is set
3. Verify session cookie settings
```

## 📚 API Response Format

### Success Response
```json
{
    "message": "Operation successful",
    "data": { ... }
}
```

### Error Response
```json
{
    "message": "Error description",
    "status": 400
}
```

## 🚀 Production Deployment

For production deployment:

1. **Update .env:**
   ```env
   NODE_ENV=production
   SESSION_SECRET=strong_random_secret_key
   # Use strong, unique values
   ```

2. **Set HTTPS:** Update session cookie settings
   ```js
   cookie: { secure: true, httpOnly: true }
   ```

3. **Database:** Use production MySQL server with backups

4. **Use Process Manager:** PM2 or similar
   ```bash
   npm install -g pm2
   pm2 start backend/server.js
   pm2 save
   ```

5. **Reverse Proxy:** Configure Nginx/Apache for port 80/443

## 📝 Dummy Data

The schema.sql includes dummy data:

### Users
- 1 Admin account
- 2 Regular users
- 2 Worker accounts

### Complaints
- 5 sample complaints with different statuses

### Workers
- 2 workers assigned to different areas

### Assignments
- 3 sample assignments showing workflow progression

### Smart Bins
- 5 bins in different locations with various statuses

## 📖 Code Comments

All code files include:
- Function descriptions
- Parameter explanations
- Logic comments for complex sections
- Section headers for easy navigation

## 🤝 Contributing

To extend this project:

1. **Add new features** in respective route files
2. **Update schema.sql** if adding database tables
3. **Create new page** in `/public/` if needed
4. **Add validation** in middleware/validators.js
5. **Keep code organized** following MVC pattern

## 📄 License

This project is open source and available for educational purposes.

## 🆘 Support

For issues or questions:
1. Check the troubleshooting section
2. Review code comments
3. Check browser console for errors
4. Verify MySQL connection
5. Check .env configuration

## 📌 Important Notes

1. **First Time Setup:**
   - Run `npm install` to install dependencies
   - Import schema.sql to create database
   - Ensure MySQL server is running
   - Update .env with your credentials

2. **Development:**
   - Use `npm run dev` for auto-reload
   - Check browser console (F12) for frontend errors
   - Check terminal for backend errors

3. **File Upload:**
   - Images stored in `/uploads/` folder
   - Make sure folder is writable
   - Maximum 5MB per file

4. **Session Management:**
   - Sessions persist for 24 hours by default
   - Modify in server.js if needed
   - Clear cookies to logout completely

---

**Happy Coding! 🚀**

Built with ❤️ for efficient garbage management
