"use client"
import { GoogleAuthCard } from "@/components/auth/google-auth-card"
import { getBeans } from "@/lib/bean-api"
import { Button } from "@/components/ui/button"

export default function LoginPage() {
  return (
    <main className="flex min-h-screen items-center justify-center px-4">
      <GoogleAuthCard
        clientId={process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID!}
        backendUrl={process.env.NEXT_PUBLIC_API_BASE_URL!}
        onSuccess={(user) => {
          console.log("Authenticated user:", user)
        }}
      />
      <Button
        onClick={() => {
          getBeans();
        }}
      >

    </Button>
    </main>
  )
}
