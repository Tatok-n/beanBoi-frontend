import * as React from "react"
import { BaseTile } from "@/components/homeScreen/tile"
import {
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
} from "@/components/ui/card"

type CustomTileProps = {
  description?: string
  children?: React.ReactNode
  size?: "sm" | "md" | "lg"
}

export function TopBeansTile({
  size = "md",
}: CustomTileProps) {
  return (
    <BaseTile variant="default" size={size}>
      <CardHeader className="p-0">
        <CardTitle>Top Beans</CardTitle>
        <CardDescription>Your most frequently used beans</CardDescription>
      </CardHeader>

      <CardContent className="p-16">
        <ul className="space-y-3">
          <li className="text-primary">
            <h2 className="text-2xl font-extrabold tracking-tight">1. Tanzania Peaberry</h2>
          </li>
          <li className="text-primary/70">
            <h3 className="text-xl font-semibold">2. Ethiopian Yirgacheffe</h3>
          </li>
          <li className="text-primary/40">
            <h4 className="text-lg font-medium">3. Costa Rica Black honey</h4>
          </li>
        </ul>
      </CardContent>
    </BaseTile>
  )
}
