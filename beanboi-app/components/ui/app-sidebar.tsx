"use client"

import { usePathname } from "next/navigation"
import Link from "next/link"
import { Home, Settings, Coffee, Book} from "lucide-react"

import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuItem,
  SidebarMenuButton,
} from "@/components/ui/sidebar"

// Define your routes here
const navItems = [
  { title: "Dashboard", href: "/dashboard", icon: Home },
  { title: "Beans", href: "/dashboard/beans", icon: Coffee },
  { title: "Recipes", href: "/dashboard/recipes", icon: Book },
  { title: "Grinders", href: "/dashboard/grinders", icon: Book },
  { title: "Settings", href: "/dashboard/settings", icon: Settings },
]

export function AppSidebar() {
  const pathname = usePathname()

  return (
    <Sidebar className="z-100">
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Application</SidebarGroupLabel>
          <SidebarMenu>
            {navItems.map((item) => {

              return (
                <SidebarMenuItem key={item.title}>
                  <SidebarMenuButton asChild>
                    <Link href={item.href}>
                      <item.icon />
                      <span>{item.title}</span>
                    </Link>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              )
            })}
          </SidebarMenu>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  )
}
