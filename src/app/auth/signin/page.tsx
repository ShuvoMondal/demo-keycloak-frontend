"use client"

import { getProviders } from "next-auth/react"
import { useSession, signOut } from "next-auth/react"
import { useEffect, useState } from "react"
import LoadingSpinner from "@/components/LoadingSpinner"
import { clearAuthData } from "@/utils/auth"

export default function SignIn() {
  const { data: session, status } = useSession()
  const [providers, setProviders] = useState<any>(null)

  useEffect(() => {
    const fetchProviders = async () => {
      const res = await getProviders()
      setProviders(res)
    }
    fetchProviders()
  }, [])

  const handleSignOut = async () => {
    try {
      // First clear all auth data
      clearAuthData();
      
      // Sign out from NextAuth
      await signOut({ 
        callbackUrl: "/",
        redirect: false  // We'll handle redirect manually
      });
      
      // Force redirect after logout
      setTimeout(() => {
        window.location.href = "/";
      }, 500);
    } catch (error) {
      console.error("Logout error:", error);
      // Fallback: clear data and force redirect
      clearAuthData();
      window.location.href = "/";
    }
  }

  if (status === "loading") {
    return <LoadingSpinner />
  }

  // If user is already signed in, show option to continue or sign out
  if (session) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 flex items-center justify-center px-4">
        <div className="max-w-md w-full space-y-8 bg-white dark:bg-gray-800 p-8 rounded-xl shadow-lg">
          <div className="text-center">
            <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
              Already Signed In
            </h1>
            <p className="text-gray-600 dark:text-gray-300 mb-8">
              You are currently signed in as {session.user?.name || session.user?.email}
            </p>
          </div>

          <div className="space-y-4">
            <button
              onClick={() => window.location.href = '/dashboard'}
              className="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 font-medium transition-colors duration-200"
            >
              Go to Dashboard
            </button>

            <button
              onClick={handleSignOut}
              className="w-full flex justify-center py-3 px-4 border border-gray-300 dark:border-gray-600 rounded-lg shadow-sm text-gray-700 dark:text-gray-200 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 font-medium transition-colors duration-200"
            >
              Sign Out and Sign In as Different User
            </button>
          </div>
        </div>
      </div>
    )
  }

  // Show login interface for users who are not signed in
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 flex items-center justify-center px-4">
      <div className="max-w-md w-full space-y-8 bg-white dark:bg-gray-800 p-8 rounded-xl shadow-lg">
        <div className="text-center">
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
            Sign In
          </h1>
          <p className="text-gray-600 dark:text-gray-300 mb-8">
            Sign in to your account using Keycloak
          </p>
        </div>

        <div className="space-y-4">
          {providers &&
            Object.values(providers).map((provider: any) => (
              <div key={provider.name}>
                <form action={`/api/auth/signin/${provider.id}`} method="POST">
                  <button
                    type="submit"
                    className="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 font-medium transition-colors duration-200"
                  >
                    Sign In with {provider.name}
                  </button>
                  <input type="hidden" name="callbackUrl" value="/dashboard" />
                </form>
              </div>
            ))
          }

          <div className="text-center">
            <a href="/" className="text-sm text-blue-600 hover:text-blue-500">
              ← Back to Home
            </a>
          </div>
        </div>

        <div className="text-center text-sm text-gray-500 dark:text-gray-400">
          <p>Powered by Keycloak Authentication</p>
        </div>
      </div>
    </div>
  )
}
