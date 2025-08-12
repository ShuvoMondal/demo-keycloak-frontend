"use client"

import { signIn } from "next-auth/react"

export default function LandingPage() {
  const handleSignIn = () => {
    // Use NextAuth signIn but redirect to login page first, not dashboard
    signIn("keycloak")
  }

  const handleSignUp = () => {
    // Redirect to Keycloak registration page
    // Update this URL with your actual Keycloak realm and registration endpoint
    const keycloakUrl = process.env.NEXT_PUBLIC_KEYCLOAK_URL || "http://localhost:8080"
    const realmName = process.env.NEXT_PUBLIC_KEYCLOAK_REALM || "your-realm-name"
    const clientId = process.env.NEXT_PUBLIC_KEYCLOAK_CLIENT_ID || "FE-CLIENT"
    const redirectUri = encodeURIComponent(`${window.location.origin}/api/auth/callback/keycloak`)
    
    const registrationUrl = `${keycloakUrl}/realms/${realmName}/protocol/openid-connect/registrations?client_id=${clientId}&response_type=code&scope=openid&redirect_uri=${redirectUri}`
    
    window.location.href = registrationUrl
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 flex items-center justify-center px-4">
      <div className="max-w-md w-full space-y-8 bg-white dark:bg-gray-800 p-8 rounded-xl shadow-lg">
        <div className="text-center">
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
            Welcome
          </h1>
          <p className="text-gray-600 dark:text-gray-300 mb-8">
            Sign in to your account or create a new one to get started
          </p>
        </div>

        <div className="space-y-4">
          <button
            onClick={handleSignIn}
            className="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 font-medium transition-colors duration-200"
          >
            Sign In
          </button>

          <button
            onClick={handleSignUp}
            className="w-full flex justify-center py-3 px-4 border border-gray-300 dark:border-gray-600 rounded-lg shadow-sm text-gray-700 dark:text-gray-200 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 font-medium transition-colors duration-200"
          >
            Sign Up
          </button>
        </div>

        <div className="text-center text-sm text-gray-500 dark:text-gray-400">
          <p>Powered by Keycloak Authentication</p>
        </div>
      </div>
    </div>
  )
}
