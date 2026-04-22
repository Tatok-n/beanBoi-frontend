import { Geist, Geist_Mono, Noto_Serif } from "next/font/google"
import "./globals.css"

import { ThemeProvider } from "@/components/theme-provider"
import { cn } from "@/lib/utils"
import { SidebarProvider, SidebarTrigger, SidebarInset } from "@/components/ui/sidebar"
import { AppSidebar } from "@/components/ui/app-sidebar"
import type { Metadata } from "next"

const notoSerif = Noto_Serif({ subsets: ['latin'], variable: '--font-serif' })

const fontSans = Geist({
  subsets: ["latin"],
  variable: "--font-sans",
})

export const viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
}

const fontMono = Geist_Mono({
  subsets: ["latin"],
  variable: "--font-mono",
})

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html
      lang="en"
      suppressHydrationWarning
      className={cn("antialiased", fontSans.variable, fontMono.variable, "font-serif", notoSerif.variable)}
    >
      <body>
        <main className="flex-1 overflow-auto p-6">
          <ThemeProvider>
            <SidebarProvider defaultOpen={false}>
            <AppSidebar />
              <SidebarInset className="flex flex-col flex-1 w-full">
                <header className="flex h-14 items-center gap-4 border-b bg-background px-6">
                  <SidebarTrigger  />
                </header>
                {children}
              </SidebarInset>
            </SidebarProvider>
          </ThemeProvider>
        </main>
      </body>
    </html>
  )
}
