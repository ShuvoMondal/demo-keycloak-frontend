"use client"

import { useSession } from "next-auth/react"
import { useEffect } from "react"
import { useRouter } from "next/navigation"
import LandingPage from "@/components/LandingPage"
import LoadingSpinner from "@/components/LoadingSpinner"

export default function Home() {
  const { data: session, status } = useSession()
  const router = useRouter()

  useEffect(() => {
    if (session) {
      router.push('/dashboard')
    }
  }, [session, router])

  if (status === "loading") {
    return <LoadingSpinner />
  }

  if (session) {
    return <LoadingSpinner />
  }

  return <LandingPage />
}
