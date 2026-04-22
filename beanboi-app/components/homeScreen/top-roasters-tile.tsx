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

export function TopRoastersTile({
  size = "md",
}: CustomTileProps) {
  return (
    <BaseTile variant="default" size={size}>
      <CardHeader className="p-0">
        <CardTitle>Top Roasters</CardTitle>
        <CardDescription>Your favorite roasters</CardDescription>
      </CardHeader>

      <CardContent className="p-16">
        <ul className="space-y-3">
          <li className="text-primary">
            <h1 className="text-2xl font-extrabold tracking-tight">1. Faro</h1>
          </li>
          <li className="text-primary/70">
            <h2 className="text-xl font-semibold">2. DAK</h2>
          </li>
          <li className="text-primary/40">
            <h3 className="text-lg font-medium">3. Pista</h3>
          </li>
        </ul>
      </CardContent>
    </BaseTile>
  )
}
