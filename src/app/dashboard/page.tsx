"use client"

import { useSession, signOut } from "next-auth/react"
import { useRouter } from "next/navigation"
import { useEffect } from "react"
import LoadingSpinner from "@/components/LoadingSpinner"
import { clearAuthData } from "@/utils/auth"

export default function Dashboard() {
  const { data: session, status } = useSession()
  const router = useRouter()

  useEffect(() => {
    if (status !== "loading" && !session) {
      router.push("/")
    }
  }, [session, status, router])

  if (status === "loading") {
    return <LoadingSpinner />
  }

  if (!session) {
    return null
  }

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

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800">
      <div className="container mx-auto px-4 py-8">
        <div className="bg-white dark:bg-gray-800 rounded-xl shadow-lg p-8">
          <div className="flex justify-between items-center mb-8">
            <h1 className="text-3xl font-bold text-gray-900 dark:text-white">
              Dashboard
            </h1>
            <button
              onClick={handleSignOut}
              className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors duration-200"
            >
              Sign Out
            </button>
          </div>

          <div className="space-y-6">
            <div className="bg-gray-50 dark:bg-gray-700 rounded-lg p-6">
              <h2 className="text-xl font-semibold text-gray-900 dark:text-white mb-4">
                Welcome back!
              </h2>
              <p className="text-gray-600 dark:text-gray-300 mb-4">
                You have successfully signed in with Keycloak.
              </p>
              
              {session.user && (
                <div className="space-y-2">
                  <p className="text-sm text-gray-600 dark:text-gray-300">
                    <strong>Name:</strong> {session.user.name || "Not provided"}
                  </p>
                  <p className="text-sm text-gray-600 dark:text-gray-300">
                    <strong>Email:</strong> {session.user.email || "Not provided"}
                  </p>
                </div>
              )}
            </div>

            <div className="grid md:grid-cols-2 gap-6">
              <div className="bg-blue-50 dark:bg-blue-900/20 rounded-lg p-6">
                <h3 className="text-lg font-semibold text-blue-900 dark:text-blue-100 mb-2">
                  Session Status
                </h3>
                <p className="text-blue-700 dark:text-blue-300">
                  ✅ Authenticated with Keycloak
                </p>
              </div>

              <div className="bg-green-50 dark:bg-green-900/20 rounded-lg p-6">
                <h3 className="text-lg font-semibold text-green-900 dark:text-green-100 mb-2">
                  Quick Actions
                </h3>
                <p className="text-green-700 dark:text-green-300">
                  🚀 Ready to start building!
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
