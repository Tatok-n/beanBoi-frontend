import { Geist, Geist_Mono, Noto_Serif } from "next/font/google"
import "./globals.css"

import { ThemeProvider } from "@/components/theme-provider"
import { cn } from "@/lib/utils"
import { SidebarProvider, SidebarTrigger, SidebarInset } from "@/components/ui/sidebar"
import { AppSidebar } from "@/components/ui/app-sidebar"

const notoSerif = Noto_Serif({ subsets: ['latin'], variable: '--font-serif' })

const fontSans = Geist({
  subsets: ["latin"],
  variable: "--font-sans",
})

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
        <ThemeProvider>
          {/* SidebarProvider manages state globally */}
          <SidebarProvider>

            {/* 1. Render the persistent sidebar */}
            <AppSidebar />

            {/* 2. SidebarInset pushes the content to the right of the sidebar */}
            <SidebarInset className="flex flex-col flex-1 w-full overflow-hidden">

              {/* Optional: Add a global header with a trigger button for mobile */}
              <header className="flex h-14 items-center gap-4 border-b bg-background px-6">
                <SidebarTrigger />
              </header>

              {/* 3. Render the specific page content here */}
              <main className="flex-1 overflow-auto p-6">
                {children}
              </main>

            </SidebarInset>

          </SidebarProvider>
        </ThemeProvider>
      </body>
    </html>
  )
}
