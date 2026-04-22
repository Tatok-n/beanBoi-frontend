import * as React from "react"
import { BaseTile } from "@/components/homeScreen/tile"
import {
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
} from "@/components/ui/card"
import Heatmap from "@/components/ui/heatmap";
import { formatHex, parse } from "culori";

type CustomTileProps = {
  description?: string
  children?: React.ReactNode
  size?: "sm" | "md" | "lg"
}

export function HeatmapTile({
  size = "md",
}: CustomTileProps) {
  return (
    <BaseTile variant="default" size={size}>
      <CardHeader className="p-0">
        <CardTitle>Heatmap of coffee</CardTitle>
        <CardDescription>You have had the most coffee on XXXX!</CardDescription>
      </CardHeader>

      <CardContent className="p-16 pt-4">
        <Heatmap
          data={sampleData}
          startDate={new Date("2026-03-1")}
          endDate={new Date("2026-04-1")}
          colorMode="interpolate"
          minColor={minColor}
          maxColor={maxColor}
          cellSize={32}
        />
      </CardContent>
    </BaseTile>
  )
}

// Has to be hardcoded unfortunately
const maxColor = formatHex("oklch(0.769 0.188 70.08)");
const minColor = formatHex("rgb(51, 51, 51)");

const sampleData = [
  { date: "2026-03-1", value: 1 },
  { date: "2026-03-2", value: 3 },
  { date: "2026-03-3", value: 4 },
  { date: "2026-03-4", value: 2 },
  { date: "2026-03-5", value: 5 },
  { date: "2026-03-6", value: 2 },
  { date: "2026-03-7", value: 2 },
  { date: "2026-03-8", value: 5 },
  { date: "2026-03-9", value: 1 },
  { date: "2026-03-10", value: 1 },
  { date: "2026-03-11", value: 5 },
  { date: "2026-03-12", value: 2 },
  { date: "2026-03-13", value: 1 },
  { date: "2026-03-14", value: 1 },
  { date: "2026-03-15", value: 1 },
  { date: "2026-03-16", value: 5 },
  { date: "2026-03-17", value: 1 },
  { date: "2026-03-18", value: 5 },
  { date: "2026-03-19", value: 5 },
  { date: "2026-03-20", value: 4 },
  { date: "2026-03-21", value: 1 },
  { date: "2026-03-22", value: 4 },
  { date: "2026-03-23", value: 3 },
  { date: "2026-03-24", value: 1 },
  { date: "2026-03-25", value: 1 },
  { date: "2026-03-26", value: 1 },
  { date: "2026-03-27", value: 1 },
  { date: "2026-03-28", value: 1 },
  { date: "2026-03-29", value: 4 },
  { date: "2026-03-30", value: 4 },
];
