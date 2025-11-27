# ESD Academia - Course Management System

A full-stack web application for managing academic domains, courses, faculty, schedules, and student enrollments using Spring Boot and React.

## ✨ Features

- 🔐 **Google OAuth 2.0 Authentication** - Secure admin login using Google accounts
- 📚 **Domain Management** - Support for multiple academic programs (MTech CSE, IMTech ECE, etc.)
- 📅 **Course Timetable** - Display course schedules with faculty and room details
- 👨‍🏫 **Faculty Information** - View faculty assigned to each course
- 👥 **Student Enrollment** - View students enrolled in each course
- 🎯 **Role-Based Access** - Admin-only access to manage academic data

## 🏗️ Architecture

### Backend (Spring Boot)
- **Framework**: Spring Boot 3.2.0
- **Database**: MySQL 
- **Authentication**: Google OAuth 2.0 ID Token verification
- **API**: RESTful endpoints

### Frontend (React)
- **Framework**: React 18.2.0
- **Routing**: React Router v6
- **HTTP Client**: Axios
- **Authentication**: Google Identity Services

## 📋 Prerequisites

Before running the application, ensure you have:

- ✅ Java 17 or higher
- ✅ Node.js 14+ and npm
- ✅ MySQL 8.0+
- ✅ Google Cloud Console account (for OAuth setup)

## 🚀 Quick Start

### 1. Google OAuth Setup (Required - 5 minutes)

**This is the most important step!** Your application won't work without it.

Follow the detailed guide in [`GOOGLE_OAUTH_SETUP.md`](GOOGLE_OAUTH_SETUP.md) to:
1. Create a Google Cloud project
2. Set up OAuth 2.0 credentials
3. Configure your application

### 2. Database Setup

```sql
-- MySQL should be running on localhost:3306
-- Database 'academia' will be created automatically

-- Create an admin user (replace with your Google email)
-- Run the script: create-admin-user.sql
mysql -u nikx -p < create-admin-user.sql
```

Edit `create-admin-user.sql` and replace `your.email@gmail.com` with your actual Google account email.

### 3. Configure Backend

```powershell
# Set Google OAuth Client ID (after obtaining from Google Cloud Console)
setx GOOGLE_OAUTH_CLIENT_ID "your-client-id.apps.googleusercontent.com"

# Restart your terminal for the environment variable to take effect
```

### 4. Configure Frontend

Edit `Frontend\.env` and replace the placeholder:
```
REACT_APP_GOOGLE_CLIENT_ID=your-actual-client-id.apps.googleusercontent.com
```

### 5. Start the Application

**Option A: Use the Startup Script (Recommended)**
```powershell
.\start-app.ps1
```

**Option B: Manual Start**

Terminal 1 - Backend:
```powershell
cd Backend
.\mvnw spring-boot:run
```

Terminal 2 - Frontend:
```powershell
cd Frontend
npm install
npm start
```

### 6. Access the Application

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8090

## 📁 Project Structure

```
ESD/
├── Backend/
│   ├── src/main/java/com/example/jpas/
│   │   ├── config/          # Security & OAuth configuration
│   │   ├── controller/      # REST API endpoints
│   │   ├── entity/          # JPA entities
│   │   ├── service/         # Business logic
│   │   ├── repo/            # Data repositories
│   │   ├── dto/             # Data transfer objects
│   │   └── helper/          # Request interceptor
│   └── src/main/resources/
│       └── application.properties
├── Frontend/
│   ├── src/
│   │   ├── components/      # React components
│   │   ├── utils/           # API utilities
│   │   └── Styles/          # CSS files
│   └── .env                 # Environment variables
├── GOOGLE_OAUTH_SETUP.md    # OAuth setup guide
├── start-app.ps1            # Startup script
├── create-admin-user.sql    # Admin user creation
└── README.md                # This file
```

## 🔌 API Endpoints

### Authentication
- `POST /api/v1/auth/admin/google` - Login with Google OAuth token

### Domains
- `GET /api/v1/domain` - Get all domains

### Courses
- `GET /api/v1/courses` - Get all courses
- `GET /api/v1/byDomain/{domainId}` - Get courses by domain
- `GET /api/v1/{courseId}/faculty` - Get faculty for a course
- `GET /api/v1/schedule/{courseId}` - Get schedule for a course

### Students
- `GET /api/courses/{courseId}/students` - Get students enrolled in a course

## 🔒 Authentication Flow

1. User clicks "Sign in with Google"
2. Google Identity Services returns ID token
3. Frontend sends token to backend
4. Backend verifies token with Google's API
5. Backend checks user has "Admin" role
6. User info stored in localStorage
7. All subsequent API calls include token in Authorization header
8. Backend re-verifies token on each request

## 🛠️ Troubleshooting

### Authentication Issues

**Error: "Missing Google client ID"**
- Verify `GOOGLE_OAUTH_CLIENT_ID` environment variable is set
- Verify `Frontend\.env` has correct Client ID
- Restart terminal/IDE after setting environment variables

**Error: "Invalid Google ID token"**
- Ensure same Client ID is used in both backend and frontend
- Verify `http://localhost:3000` is in Authorized JavaScript origins
- Clear browser cache and cookies

**Error: "Only Admin can Login"**
- Check your User table in the database
- Ensure a user exists with your Google email and role = "Admin"
- Run the `create-admin-user.sql` script

### Database Issues

**Error: "Access denied for user 'nikx'"**
- Update `Backend/src/main/resources/application.properties`
- Change `spring.datasource.username` and `spring.datasource.password`

### Build Issues

**Backend won't compile**
```powershell
cd Backend
.\mvnw clean install
```

**Frontend won't start**
```powershell
cd Frontend
rm -r node_modules
npm install
npm start
```

## 📝 Configuration Files

### Backend Configuration
`Backend/src/main/resources/application.properties`:
```properties
server.port=8090
spring.datasource.url=jdbc:mysql://localhost:3306/academia?createDatabaseIfNotExist=true
spring.datasource.username=nikx
spring.datasource.password=nikx@12
google.oauth.client-id=${GOOGLE_OAUTH_CLIENT_ID:}
```

### Frontend Configuration
`Frontend/.env`:
```
REACT_APP_GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
```

## 🎯 Usage

1. **Login**: Use Google account with admin privileges
2. **Select Domain**: Choose from dropdown (e.g., MTech CSE, IMTech ECE)
3. **View Timetable**: See courses with faculty, schedule, and room details
4. **View Students**: Click "View Students" to see enrolled students

## 🤝 Contributing

This is a university project for ESD (Enterprise Software Development) course.

## 📄 License

This project is created for educational purposes.

## 👨‍💻 Developer Notes

- **No Traditional JWT**: This project uses Google OAuth ID tokens, not self-signed JWTs
- **Token Verification**: Each API call re-verifies the token with Google
- **Security**: Spring Security is disabled in favor of custom interceptor
- **Database**: Auto-creates tables using JPA/Hibernate

## 🆘 Need Help?

1. Check [`GOOGLE_OAUTH_SETUP.md`](GOOGLE_OAUTH_SETUP.md) for OAuth setup
2. Check [`AUTHENTICATION.md`](AUTHENTICATION.md) for authentication details
3. Review backend logs in the terminal
4. Check browser console (F12) for frontend errors

---

**Important**: Make sure to complete the Google OAuth setup before running the application!
