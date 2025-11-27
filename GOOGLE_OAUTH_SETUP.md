# Google OAuth Setup Guide

## Quick Setup (5 minutes)

### Step 1: Get Google OAuth Client ID

1. Go to https://console.cloud.google.com/
2. Click "Select a project" → "NEW PROJECT"
3. Enter project name: "ESD Academia" → Click "CREATE"
4. Wait for project creation, then click "SELECT PROJECT"

### Step 2: Enable Google OAuth

1. In the left sidebar, go to **APIs & Services** → **Credentials**
2. Click **"+ CREATE CREDENTIALS"** → **"OAuth 2.0 Client ID"**
3. If prompted to configure consent screen:
   - Click "CONFIGURE CONSENT SCREEN"
   - Choose "External" → Click "CREATE"
   - Fill in:
     - App name: `ESD Academia`
     - User support email: Your email
     - Developer contact: Your email
   - Click "SAVE AND CONTINUE" (skip optional fields)
   - Click "SAVE AND CONTINUE" on Scopes page
   - Click "SAVE AND CONTINUE" on Test users page
   - Click "BACK TO DASHBOARD"

### Step 3: Create OAuth Client ID

1. Go back to **Credentials** tab
2. Click **"+ CREATE CREDENTIALS"** → **"OAuth 2.0 Client ID"**
3. Choose Application type: **"Web application"**
4. Name: `ESD Academia Web Client`
5. Under "Authorized JavaScript origins", click "ADD URI":
   - Add: `http://localhost:3000`
6. Click "CREATE"
7. **IMPORTANT**: Copy the "Client ID" (looks like: `xxxxx-yyyyy.apps.googleusercontent.com`)

### Step 4: Configure Your Application

#### Frontend Configuration
1. Open file: `Frontend\.env`
2. Replace `YOUR_GOOGLE_CLIENT_ID_HERE` with your actual Client ID
3. Save the file

#### Backend Configuration
1. Open PowerShell as Administrator
2. Run:
   ```powershell
   setx GOOGLE_OAUTH_CLIENT_ID "YOUR_CLIENT_ID_HERE.apps.googleusercontent.com"
   ```
3. Restart your terminal/IDE for the environment variable to take effect

### Step 5: Run the Application

Use the provided `start-app.ps1` script:

```powershell
.\start-app.ps1
```

Or manually:

**Terminal 1 - Backend:**
```powershell
cd Backend
.\mvnw spring-boot:run
```

**Terminal 2 - Frontend:**
```powershell
cd Frontend
npm install
npm start
```

### Step 6: Test

1. Open browser to http://localhost:3000
2. Click "Sign in with Google"
3. Choose your Google account
4. You should be redirected to the domain page
5. Select a domain to view the course timetable

## Troubleshooting

### Error: "Missing REACT_APP_GOOGLE_CLIENT_ID"
- Make sure `.env` file exists in `Frontend` folder
- Make sure Client ID is correctly set in `.env`
- Restart `npm start`

### Error: "Missing google.oauth.client-id configuration"
- Set the environment variable: `setx GOOGLE_OAUTH_CLIENT_ID "your-client-id"`
- Restart your terminal/IDE
- Verify: `echo $env:GOOGLE_OAUTH_CLIENT_ID`

### Error: "Invalid Google ID token"
- Make sure you're using the same Client ID in both backend and frontend
- Make sure `http://localhost:3000` is added to Authorized JavaScript origins
- Try clearing browser cache and cookies

### Error: "Only Admin can Login"
- You need an admin user in your database
- Check your `User` table and set the role to "Admin" for your email

## Database Setup

Make sure you have:
1. MySQL running on localhost:3306
2. Database user: `nikx` with password: `nikx@12`
3. Database will be auto-created as `academia`
4. At least one user with role "Admin" and your Google email

## Need Help?

If you encounter issues:
1. Check backend logs in the terminal running Spring Boot
2. Check browser console (F12) for frontend errors
3. Verify database connection in `application.properties`
