# Keycloak Authentication Setup

This Next.js application is configured with Keycloak authentication using NextAuth.js.

## Environment Configuration

Update the following values in your `.env.local` file:

```env
# Generate a secret key for NextAuth
NEXTAUTH_SECRET=your-nextauth-secret-key-here

# Your application URL
NEXTAUTH_URL=http://localhost:3000

# Keycloak configuration
KEYCLOAK_CLIENT_ID=FE-CLIENT
KEYCLOAK_CLIENT_SECRET=0shy4jNFuhOdljPjdtcW3zXRXHYokHBa
KEYCLOAK_ISSUER=http://localhost:8080/realms/your-realm-name

# Public variables for client-side (replace with your actual values)
NEXT_PUBLIC_KEYCLOAK_URL=http://localhost:8080
NEXT_PUBLIC_KEYCLOAK_REALM=your-realm-name
NEXT_PUBLIC_KEYCLOAK_CLIENT_ID=FE-CLIENT
```

## Important Setup Steps

### 1. Update Realm Name
Replace `your-realm-name` in the environment variables with your actual Keycloak realm name.

### 2. Generate NextAuth Secret
Generate a secure secret for NextAuth:
```bash
openssl rand -base64 32
```

### 3. Keycloak Client Configuration
Make sure your Keycloak client (`FE-CLIENT`) is configured with:

- **Client Type**: OpenID Connect
- **Access Type**: confidential
- **Valid Redirect URIs**: 
  - `http://localhost:3000/api/auth/callback/keycloak`
  - Add your production URLs when deploying
- **Web Origins**: 
  - `http://localhost:3000`
  - Add your production URLs when deploying

### 4. Enable User Registration (Optional)
To allow users to register via the Sign Up button:

1. In Keycloak Admin Console, go to your realm settings
2. Navigate to "Login" tab
3. Enable "User registration"
4. Save the configuration

## Features

### Landing Page
- Clean, responsive design
- **Sign In** button → redirects to Keycloak login
- **Sign Up** button → redirects to Keycloak registration page

### Authentication Flow
1. User clicks "Sign In" → redirects to Keycloak login
2. After successful authentication → redirects to dashboard
3. User clicks "Sign Up" → redirects to Keycloak registration page
4. After registration → can sign in normally

### Dashboard
- Protected route (requires authentication)
- Displays user information from Keycloak
- Sign out functionality

## Running the Application

```bash
npm run dev
```

Visit `http://localhost:3000` to see the landing page.

## File Structure

```
src/
├── app/
│   ├── api/auth/[...nextauth]/
│   │   └── route.ts              # NextAuth configuration
│   ├── auth/signin/
│   │   └── page.tsx             # Custom sign-in page
│   ├── dashboard/
│   │   └── page.tsx             # Protected dashboard
│   ├── layout.tsx               # Root layout with SessionProvider
│   └── page.tsx                 # Landing page with auth logic
├── components/
│   ├── LandingPage.tsx          # Landing page component
│   ├── LoadingSpinner.tsx       # Loading component
│   └── SessionProvider.tsx     # Client-side session provider
└── types/
    └── next-auth.d.ts           # NextAuth TypeScript definitions
```

## Troubleshooting

### Common Issues

1. **"Invalid redirect URI" error**
   - Check that your redirect URIs in Keycloak match exactly
   - Ensure no trailing slashes

2. **Registration page not found**
   - Verify that user registration is enabled in your Keycloak realm
   - Check that the realm name in environment variables is correct

3. **CORS errors**
   - Add your frontend URL to "Web Origins" in Keycloak client settings

### Debug Mode
Set `NEXTAUTH_DEBUG=true` in your environment variables to enable debug logging.
