"use client"

import { useCallback, useEffect, useRef, useState } from "react"
import Script from "next/script"
import { Loader2 } from "lucide-react"

import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"
import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { Separator } from "@/components/ui/separator"

declare global {
  interface Window {
    google?: any
  }
}

type GoogleCredentialResponse = {
  credential: string
  select_by: string
}

type User = {
  id: string
  email: string
}

type GoogleAuthCardProps = {
  clientId: string
  backendUrl: string
  onSuccess?: (user: User) => void
}

export function GoogleAuthCard({
  clientId,
  backendUrl,
  onSuccess,
}: GoogleAuthCardProps) {
  const buttonRef = useRef<HTMLDivElement | null>(null)
  const [scriptLoaded, setScriptLoaded] = useState(false)
  const [rendered, setRendered] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleCredential = useCallback(
    async (response: GoogleCredentialResponse) => {
      try {
        setLoading(true)
        setError(null)

        const res = await fetch(`${backendUrl}/api/auth/google`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          credentials: "include",
          body: JSON.stringify({
            token: response.credential,
          }),
        })

        if (!res.ok) {
          throw new Error(`Authentication failed (${res.status})`)
        }

        const user = await res.json()
        onSuccess?.(user)
      } catch (err) {
        setError(
          err instanceof Error ? err.message : "Something went wrong during sign in"
        )
      } finally {
        setLoading(false)
      }
    },
    [backendUrl, onSuccess]
  )

  useEffect(() => {
    if (!scriptLoaded || !window.google || !buttonRef.current || rendered) return

    window.google.accounts.id.initialize({
      client_id: clientId,
      callback: handleCredential,
    })

    window.google.accounts.id.renderButton(buttonRef.current, {
      theme: "outline",
      size: "large",
      text: "signin_with",
      shape: "rectangular",
      width: 320,
    })

    setRendered(true)
  }, [scriptLoaded, rendered, clientId, handleCredential])

  const retryRender = () => {
    setError(null)
    setRendered(false)
  }

  return (
    <>
      <Script
        src="https://accounts.google.com/gsi/client"
        strategy="afterInteractive"
        onLoad={() => setScriptLoaded(true)}
      />

      <Card className="w-full max-w-md shadow-sm">
        <CardHeader className="space-y-1">
          <CardTitle className="text-2xl">Sign in</CardTitle>
          <CardDescription>
            Continue with your Google account to access BeanBoi.
          </CardDescription>
        </CardHeader>

        <CardContent className="space-y-4">
          <div className="flex justify-center">
            {!scriptLoaded ? (
              <div className="flex h-10 w-[320px] items-center justify-center rounded-md border text-sm text-muted-foreground">
                Loading Google…
              </div>
            ) : (
              <div ref={buttonRef} className="min-h-[40px]" />
            )}
          </div>

          {loading && (
            <div className="flex items-center justify-center gap-2 text-sm text-muted-foreground">
              <Loader2 className="h-4 w-4 animate-spin" />
              Signing you in...
            </div>
          )}

          {error && (
            <Alert variant="destructive">
              <AlertTitle>Sign-in failed</AlertTitle>
              <AlertDescription>{error}</AlertDescription>
            </Alert>
          )}

          <Separator />

          <p className="text-center text-sm text-muted-foreground">
            We only use your Google account to identify you and create your app account.
          </p>
        </CardContent>

        <CardFooter className="flex flex-col gap-2">
          <Button
            type="button"
            variant="outline"
            className="w-full"
            onClick={retryRender}
            disabled={!scriptLoaded}
          >
            Retry Google button
          </Button>
        </CardFooter>
      </Card>
    </>
  )
}
