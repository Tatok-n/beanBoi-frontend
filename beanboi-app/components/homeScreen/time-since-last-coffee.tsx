import * as React from "react"
import { BaseTile } from "@/components/homeScreen/tile"
import {
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/components/ui/card"

type CustomTileProps = {
  description?: string
  children?: React.ReactNode
  size?: "sm" | "md" | "lg"
}

export function TimeSinceLastCoffeeTile({
  size = "md",
}: CustomTileProps) {
  return (
    <BaseTile variant="default" size={size}>
      <CardHeader className="p-0">
        <CardTitle className="font-semibold">00:00:00</CardTitle>
        <CardDescription>Time since last coffee</CardDescription>
      </CardHeader>
    </BaseTile>
  )
}
