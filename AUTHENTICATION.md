# Google OAuth 2.0 Authentication Setup

## Overview

This application uses **Google OAuth 2.0 ID Tokens** for authentication, not traditional JWT. Google generates and signs the tokens, and we verify them on each request.

## Quick Setup

### 1. Create OAuth Client ID

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Navigate to **APIs & Services** → **Credentials**
4. Click **Create Credentials** → **OAuth 2.0 Client ID**
5. Configure consent screen if prompted (External, add app name and emails)
6. Choose **Web application** as application type
7. Add authorized JavaScript origin: `http://localhost:3000`
8. Click **Create** and copy the Client ID

### 2. Configure Backend

**Option A: Environment Variable (Recommended)**
```powershell
# Windows
setx GOOGLE_OAUTH_CLIENT_ID "your-client-id.apps.googleusercontent.com"

# Restart terminal, then run:
cd Backend
.\mvnw spring-boot:run
```

**Option B: Direct in application.properties**
```properties
# Backend/src/main/resources/application.properties
google.oauth.client-id=your-client-id.apps.googleusercontent.com
```

### 3. Configure Frontend

Create/edit `Frontend/.env`:
```
REACT_APP_GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
```

**Important**: Restart `npm start` after changing `.env` file.

### 4. Create Admin User

You need a user in the database with the "Admin" role matching your Google email.

Edit and run `create-admin-user.sql`:
```sql
INSERT INTO User (name, email, role, password) 
VALUES ('Your Name', 'your.google.email@gmail.com', 'Admin', 'dummy');
```

## How It Works

### Authentication Flow

```
1. User → Frontend: Click "Sign in with Google"
2. Frontend → Google: Request authentication
3. Google → User: Show login page
4. User → Google: Enter credentials
5. Google → Frontend: Return ID Token (JWT signed by Google)
6. Frontend → Backend: POST /api/v1/auth/admin/google with token
7. Backend → Google: Verify token signature and claims
8. Backend → Database: Check user exists with Admin role
9. Backend → Frontend: Return user info
10. Frontend: Store token in localStorage

Subsequent API Calls:
1. Frontend → Backend: Add "Authorization: Bearer <token>" header
2. Backend → RequestInterceptor: Extract token
3. Backend → Google: Re-verify token
4. Backend → API: Process request if valid
```

### Key Components

**Backend:**
- `GoogleOAuthService` - Verifies ID tokens using Google's public keys
- `AdminService` - Validates user has Admin role
- `RequestInterceptor` - Checks Authorization header on all requests
- `SecurityConfig` - Configures which paths require authentication

**Frontend:**
- `Login.jsx` - Renders Google Sign-In button using Google Identity Services
- `api.js` - Axios interceptor adds Authorization header to all requests
- `UserContext.js` - Manages authenticated user state

## Security Features

✅ **Token Verification**: Every request re-verifies the token with Google  
✅ **Role-Based Access**: Only users with "Admin" role can access the system  
✅ **CORS Protection**: Backend only accepts requests from localhost:3000  
✅ **No Password Storage**: Authentication handled entirely by Google  
✅ **Token Expiration**: Google tokens expire after ~1 hour  

## Troubleshooting

### "Missing google.oauth.client-id configuration"
- Backend environment variable not set
- Solution: `setx GOOGLE_OAUTH_CLIENT_ID "your-id"` and restart terminal

### "Missing REACT_APP_GOOGLE_CLIENT_ID"
- Frontend .env file missing or incorrect
- Solution: Create `Frontend/.env` with correct Client ID, restart npm

### "Invalid Google ID token"
- Client ID mismatch between frontend and backend
- Unauthorized JavaScript origin
- Solution: Use same Client ID everywhere, add `http://localhost:3000` to Google Console

### "Only Admin can Login"
- User doesn't exist in database
- User role is not "Admin"
- Email in database doesn't match Google account email
- Solution: Run `create-admin-user.sql` with your Google email

### Token expires quickly
- Google ID tokens expire after ~1 hour
- Solution: This is normal. User needs to log in again, or implement token refresh

## Why Not Traditional JWT?

**Traditional JWT**: Your backend generates and signs tokens with a secret key.

**Google ID Token (Current)**: Google generates and signs tokens. More secure because:
- ✅ No secret key to manage or leak
- ✅ Google handles token generation complexity
- ✅ Leverages Google's security infrastructure
- ✅ Users can revoke access from Google account settings
- ✅ Single sign-on across applications

## Advanced Configuration

### Using Different Port
```properties
# Backend
server.port=9090
```
Update frontend API base URL in `src/utils/api.js`:
```javascript
baseURL: "http://localhost:9090/api"
```

### Production Deployment
1. Get production domain
2. Add domain to Authorized JavaScript origins in Google Console
3. Update frontend .env with production Client ID
4. Set backend environment variable on server
5. Update CORS configuration in backend to allow production origin

## References

- [Google Identity Services](https://developers.google.com/identity/gsi/web)
- [Google OAuth 2.0](https://developers.google.com/identity/protocols/oauth2)
- [ID Token Verification](https://developers.google.com/identity/sign-in/web/backend-auth)
