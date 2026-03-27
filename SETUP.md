# ⚡ Quick Setup Guide

## 5-Minute Setup to Run the Project

### Step 1: Prerequisites Check (1 min)
- [ ] Node.js installed? (`node --version` should show v14+)
- [ ] MySQL installed and running? (`mysql --version`)
- [ ] npm available? (`npm --version`)

### Step 2: Install Dependencies (2 min)
```bash
npm install
```

Output should show all packages installing without errors.

### Step 3: Setup Database (1 min)

**Option A: Command Line**
```bash
mysql -u root -p < schema.sql
```
Enter your MySQL password when prompted.

**Option B: MySQL GUI**
1. Open your MySQL client (MySQL Workbench, DBeaver, etc.)
2. Open the `schema.sql` file
3. Execute all commands

**Option C: Verify**
```bash
mysql -u root -p -e "USE smart_garbage_db; SHOW TABLES;"
```
Should show all 5 tables created.

### Step 4: Configure .env (30 sec)
Edit `.env` file with your MySQL credentials:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=YOUR_PASSWORD_HERE
DB_NAME=smart_garbage_db
DB_PORT=3306
PORT=3000
NODE_ENV=development
SESSION_SECRET=your_secret_key_change_this
```

### Step 5: Start Server (30 sec)
```bash
npm start
```

You should see:
```
╔═════════════════════════════════════════════════════╗
║   Smart Garbage Management System                    ║
║   Server running on http://localhost:3000           ║
║   Environment: development                           ║
╚═════════════════════════════════════════════════════╝
✓ Database connected successfully
```

### Step 6: Access Application
Open browser and go to: **http://localhost:3000**

## 🔓 Login Credentials

| User Type | Email | Password |
|-----------|-------|----------|
| Regular User | user1@gmail.com | user123 |
| Admin | admin@garbage.com | admin123 |
| Worker | worker1@garbage.com | worker123 |

## ✅ Test Each Feature

### 1. User Registration
```
1. Click "Register here"
2. Fill: Name, Email, Password, Select "Regular User"
3. Click "Register"
4. Login with new credentials
```

### 2. Raise Complaint (as User)
```
1. Login as user1@gmail.com
2. Click "Raise Complaint" in sidebar
3. Fill: Location, Description
4. Upload image (optional)
5. Click "Submit"
6. View in "My Complaints"
```

### 3. Admin Dashboard
```
1. Logout
2. Login as admin@garbage.com
3. View "All Complaints"
4. Click "Assign" on pending complaint
5. Select worker and assign
```

### 4. Worker Dashboard
```
1. Logout
2. Login as worker1@garbage.com
3. View assigned tasks
4. Click "Update Status"
5. Mark as "In Progress" or "Completed"
6. Upload proof image if completing
```

## 🐛 Common Issues & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| Can't connect to database | MySQL not running | Start MySQL service |
| Port 3000 already in use | Another app using port | Change PORT in .env |
| npm install fails | Node version old | Update Node.js to v14+ |
| Images not uploading | uploads folder missing | Create `/uploads` folder |
| Login fails | Invalid credentials | Check capitalization, use demo creds |
| Server crashes on start | .env missing vars | Fill all .env variables |

## 📱 Project Structure at a Glance

```
├── backend/
│   ├── server.js          ← Run with npm start
│   ├── config/db.js       ← Database connection
│   ├── routes/            ← API endpoints
│   └── middleware/        ← Authentication & validation
├── public/
│   ├── index.html         ← Login page
│   ├── dashboard.html     ← User dashboard
│   ├── admin-dashboard.html
│   ├── worker-dashboard.html
│   ├── css/               ← Styling
│   └── js/                ← Frontend logic
├── uploads/               ← Uploaded images
├── schema.sql            ← Database setup
├── package.json          ← Dependencies
├── .env                  ← Configuration
└── README.md             ← Full documentation
```

## 🎯 API Endpoints Summary

### Public
- `GET /` - Login/Register page
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login

### Protected (User)
- `GET /api/user/complaints` - List user's complaints
- `POST /api/user/complaint` - Create new complaint
- `GET /api/user/dashboard/stats` - User statistics

### Protected (Admin)
- `GET /api/admin/complaints` - All complaints
- `POST /api/admin/assign` - Assign to worker
- `GET /api/admin/workers` - List workers
- `GET /api/admin/dashboard/stats` - Admin stats

### Protected (Worker)
- `GET /api/worker/tasks` - Assigned tasks
- `PUT /api/worker/task/:id` - Update task status
- `GET /api/worker/dashboard/stats` - Worker stats

## 🚀 Next Steps After Setup

1. **Explore the UI** - Test all dashboard features
2. **Create test data** - Add more complaints, workers
3. **Review code** - Understand the architecture
4. **Customize** - Modify styles, add features
5. **Deploy** - Use Heroku, AWS, or your own server

## 🆘 Still Having Issues?

1. Check that MySQL server is **running**
2. Verify all npm packages installed: `npm list`
3. Check `.env` file has **all values filled**
4. Clear browser cache: `Ctrl+Shift+Del`
5. Restart server: `Ctrl+C` then `npm start` again
6. Check browser console: `F12` → Console tab

## 📞 Quick Checklist

- [ ] Node.js installed
- [ ] MySQL running
- [ ] npm dependencies installed
- [ ] Database created (schema.sql executed)
- [ ] .env file configured
- [ ] Server started (no errors)
- [ ] Can access http://localhost:3000
- [ ] Can login with demo credentials
- [ ] Can perform basic operations (create complaint, assign, etc.)

---

**✅ If all checkboxes are done, you're ready to go!**

Need help? Check the full README.md for detailed documentation.
