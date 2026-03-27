# 📚 API Documentation

Complete API reference for Smart Garbage Management System

## Base URL
```
http://localhost:3000/api
```

## Authentication
All protected endpoints require an active session cookie. Login first to get a session.

---

## 🔐 Authentication Endpoints

### Register User
**POST** `/auth/register`

Create a new user account

**Request Body:**
```json
{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "role": "user"  // or "worker"
}
```

**Response (201 Created):**
```json
{
    "message": "User registered successfully. Please login.",
    "userId": 5
}
```

**Validation:**
- name: required, non-empty
- email: required, valid email format, must be unique
- password: required, minimum 6 characters
- role: required, must be "user" or "worker"

---

### Login
**POST** `/auth/login`

Authenticate user and create session

**Request Body:**
```json
{
    "email": "john@example.com",
    "password": "password123"
}
```

**Response (200 OK):**
```json
{
    "message": "Login successful",
    "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "role": "user"
    }
}
```

**Error (401):**
```json
{
    "message": "Invalid email or password"
}
```

---

### Logout
**POST** `/auth/logout`

Destroy current session

**Response (200 OK):**
```json
{
    "message": "Logged out successfully"
}
```

---

### Get Current User
**GET** `/auth/me`

Get information about currently logged-in user

**Response (200 OK):**
```json
{
    "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "role": "user"
    }
}
```

**Error (401):**
```json
{
    "message": "Not logged in"
}
```

---

## 👤 User Endpoints

*Requires: Logged-in user with role "user"*

### Create Complaint
**POST** `/user/complaint`

Submit a new garbage complaint

**Request Body (multipart/form-data):**
```
location: "Market Square"
description: "Garbage overflowing for 3 days"
image: <file> (optional, max 5MB, image only)
```

**Response (201 Created):**
```json
{
    "message": "Complaint created successfully",
    "complaintId": 15
}
```

**Validation:**
- location: required, non-empty
- description: required, minimum 10 characters
- image: optional, max 5MB, only JPG/PNG/GIF allowed

---

### Get User's Complaints
**GET** `/user/complaints`

Retrieve all complaints filed by current user

**Response (200 OK):**
```json
{
    "complaints": [
        {
            "id": 1,
            "location": "Main Street",
            "description": "Garbage overflowing...",
            "image": "complaint-1234567890.jpg",
            "status": "Completed",
            "created_at": "2024-01-15T10:30:00Z"
        },
        {
            "id": 2,
            "location": "Park Avenue",
            "description": "Dirty accumulated waste...",
            "image": null,
            "status": "Pending",
            "created_at": "2024-01-14T08:45:00Z"
        }
    ]
}
```

---

### Get Complaint Details
**GET** `/user/complaint/:id`

Get detailed information about a specific complaint

**Parameters:**
- `id` (required): Complaint ID

**Response (200 OK):**
```json
{
    "complaint": {
        "id": 1,
        "user_id": 2,
        "location": "Main Street, Sector 5",
        "description": "Garbage overflowing near residential complex",
        "image": "complaint-1234567890.jpg",
        "status": "Completed",
        "created_at": "2024-01-15T10:30:00Z",
        "reporter_name": "John User"
    },
    "assignment": {
        "id": 1,
        "worker_id": 1,
        "status": "Completed",
        "assigned_at": "2024-01-15T11:00:00Z",
        "completed_at": "2024-01-15T15:30:00Z",
        "worker_name": "Mike Worker"
    }
}
```

**Error (404):**
```json
{
    "message": "Complaint not found"
}
```

---

### Get User Dashboard Stats
**GET** `/user/dashboard/stats`

Get statistics about user's complaints

**Response (200 OK):**
```json
{
    "stats": {
        "total": 5,
        "pending": 2,
        "assigned": 1,
        "completed": 2
    }
}
```

---

## 👨‍💼 Admin Endpoints

*Requires: Logged-in user with role "admin"*

### Get All Complaints
**GET** `/admin/complaints`

Retrieve all complaints in the system (paginated)

**Response (200 OK):**
```json
{
    "complaints": [
        {
            "id": 1,
            "user_id": 2,
            "location": "Main Street",
            "description": "Garbage overflowing...",
            "image": "complaint-1234567890.jpg",
            "status": "Completed",
            "created_at": "2024-01-15T10:30:00Z",
            "user_name": "John User",
            "email": "john@gmail.com"
        }
    ]
}
```

---

### Get Complaint Details (Admin View)
**GET** `/admin/complaint/:id`

Get complaint with assignment information

**Response (200 OK):**
```json
{
    "complaint": {
        "id": 1,
        "location": "Main Street",
        "description": "...",
        "user_name": "John User",
        "email": "john@gmail.com",
        "status": "Assigned"
    },
    "assignment": {
        "id": 1,
        "complaint_id": 1,
        "worker_id": 1,
        "status": "In Progress",
        "assigned_at": "2024-01-15T11:00:00Z",
        "worker_name": "Mike Worker",
        "phone": "9876543210",
        "area": "Sector 5"
    }
}
```

---

### Get All Workers
**GET** `/admin/workers`

List all registered workers

**Response (200 OK):**
```json
{
    "workers": [
        {
            "id": 1,
            "user_id": 4,
            "name": "Mike Worker",
            "phone": "9876543210",
            "area": "Sector 5",
            "email": "worker1@garbage.com"
        },
        {
            "id": 2,
            "user_id": 5,
            "name": "Tom Worker",
            "phone": "8765432109",
            "area": "Downtown",
            "email": "worker2@garbage.com"
        }
    ]
}
```

---

### Assign Complaint to Worker
**POST** `/admin/assign`

Assign a complaint to a worker

**Request Body:**
```json
{
    "complaintId": 5,
    "workerId": 1
}
```

**Response (201 Created):**
```json
{
    "message": "Assignment created successfully",
    "assignmentId": 7
}
```

**Validation:**
- complaintId: required
- workerId: required
- Complaint must not already be assigned

**Error (400):**
```json
{
    "message": "Complaint already assigned"
}
```

---

### Get Admin Dashboard Stats
**GET** `/admin/dashboard/stats`

Get comprehensive system statistics

**Response (200 OK):**
```json
{
    "stats": {
        "total_complaints": 50,
        "pending": 10,
        "assigned": 15,
        "completed": 25,
        "total_workers": 2,
        "total_assignments": 40
    },
    "workerPerformance": [
        {
            "id": 1,
            "name": "Mike Worker",
            "area": "Sector 5",
            "assigned_tasks": 20,
            "completed_tasks": 18
        },
        {
            "id": 2,
            "name": "Tom Worker",
            "area": "Downtown",
            "assigned_tasks": 20,
            "completed_tasks": 17
        }
    ]
}
```

---

### Get Smart Bins Status
**GET** `/admin/smart-bins`

Get status of all smart garbage bins

**Response (200 OK):**
```json
{
    "bins": [
        {
            "id": 1,
            "location": "Main Street",
            "status": "Full",
            "last_updated": "2024-01-15T14:35:00Z"
        },
        {
            "id": 2,
            "location": "Park Avenue",
            "status": "Half",
            "last_updated": "2024-01-15T14:20:00Z"
        }
    ]
}
```

---

### Update Smart Bin Status
**PUT** `/admin/smart-bin/:id`

Update status of a smart bin

**Parameters:**
- `id` (required): Bin ID

**Request Body:**
```json
{
    "status": "Empty"
}
```

Valid statuses: "Empty", "Half", "Full"

**Response (200 OK):**
```json
{
    "message": "Bin status updated"
}
```

---

## 👷 Worker Endpoints

*Requires: Logged-in user with role "worker"*

### Get Assigned Tasks
**GET** `/worker/tasks`

Get all tasks assigned to the worker

**Response (200 OK):**
```json
{
    "tasks": [
        {
            "id": 1,
            "complaint_id": 5,
            "status": "Assigned",
            "assigned_at": "2024-01-15T11:00:00Z",
            "completed_at": null,
            "location": "Market Square",
            "description": "Garbage overflowing...",
            "image": "complaint-123.jpg",
            "complaint_created_at": "2024-01-15T10:30:00Z",
            "user_name": "John User",
            "email": "john@gmail.com"
        }
    ],
    "workerId": 1
}
```

---

### Get Task Details
**GET** `/worker/task/:assignmentId`

Get detailed information about a specific task

**Parameters:**
- `assignmentId` (required): Assignment ID

**Response (200 OK):**
```json
{
    "task": {
        "id": 1,
        "complaint_id": 5,
        "status": "In Progress",
        "assigned_at": "2024-01-15T11:00:00Z",
        "completed_at": null,
        "proof_image": null,
        "location": "Market Square",
        "description": "Garbage overflowing for 2 days",
        "image": "complaint-123.jpg",
        "complaint_created_at": "2024-01-15T10:30:00Z",
        "user_name": "John User",
        "email": "john@gmail.com"
    }
}
```

---

### Update Task Status
**PUT** `/worker/task/:assignmentId`

Update status of assigned task

**Parameters:**
- `assignmentId` (required): Assignment ID

**Request Body (multipart/form-data):**
```
status: "In Progress"  // or "Completed"
proof: <file>         // optional, only when status is "Completed"
```

**Response (200 OK):**
```json
{
    "message": "Task status updated successfully"
}
```

**Valid statuses:**
- "In Progress" - Worker started working on the task
- "Completed" - Task is completed (complaint will also be marked completed)

---

### Get Worker Dashboard Stats
**GET** `/worker/dashboard/stats`

Get personal work statistics

**Response (200 OK):**
```json
{
    "stats": {
        "total_assignments": 25,
        "pending": 3,
        "in_progress": 2,
        "completed": 20
    }
}
```

---

## 📊 Status Codes

| Code | Meaning |
|------|---------|
| 200 | OK - Request succeeded |
| 201 | Created - Resource created successfully |
| 400 | Bad Request - Invalid input |
| 401 | Unauthorized - Not logged in or invalid credentials |
| 403 | Forbidden - User doesn't have permission |
| 404 | Not Found - Resource doesn't exist |
| 413 | Payload Too Large - File size exceeded |
| 500 | Server Error - Internal server error |

---

## 🔄 Common Request/Response Patterns

### Authentication Required
All endpoints except `/auth/register` and `/auth/login` require:
- Valid session cookie (automatically set on login)
- Proper user role

### File Upload
- Use `multipart/form-data` for requests with files
- Supported formats: JPG, PNG, GIF
- Max size: 5MB
- Stored in `/uploads/` directory

### Pagination
Future versions will support pagination with:
- `limit`: Number of records (default: 20)
- `offset`: Starting offset (default: 0)

### Filtering
Use query parameters:
```
GET /api/admin/complaints?status=Pending&location=Main
```

---

## 🧪 Testing with cURL

### Login
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user1@gmail.com","password":"user123"}' \
  -c cookies.txt
```

### Create Complaint
```bash
curl -X POST http://localhost:3000/api/user/complaint \
  -H "Content-Type: multipart/form-data" \
  -F "location=Main Street" \
  -F "description=Garbage overflowing for days" \
  -F "image=@image.jpg" \
  -b cookies.txt
```

### Get Complaints
```bash
curl -X GET http://localhost:3000/api/user/complaints \
  -b cookies.txt
```

---

## ⚠️ Error Handling

All errors follow this format:
```json
{
    "message": "Error description",
    "status": 400,
    "errors": []  // validation errors array if applicable
}
```

Validation errors example:
```json
{
    "message": "Validation failed",
    "errors": [
        {
            "field": "email",
            "message": "Invalid email format"
        },
        {
            "field": "password",
            "message": "Minimum 6 characters"
        }
    ]
}
```

---

## 🔐 Security Notes

1. **Passwords:** Always sent over HTTPS in production
2. **Sessions:** Expire after 24 hours (configurable)
3. **CORS:** Configured for frontend communication
4. **SQL Injection:** Prevented using parameterized queries
5. **File Uploads:** Validated by type and size

---

## 📞 Support

For API issues:
1. Check status codes
2. Review error messages
3. Verify request format
4. Check authentication
5. Review server logs

---

Last Updated: January 2024
API Version: 1.0
