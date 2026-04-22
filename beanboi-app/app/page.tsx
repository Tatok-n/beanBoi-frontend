"use client"

import { Button } from "@/components/ui/button"
import { BaseTile } from "@/components/homeScreen/tile"
import Heatmap from "@/components/ui/heatmap"
import { HeatmapTile } from "@/components/homeScreen/heatmaptile"
import { TopBeansTile } from "@/components/homeScreen/top-beans-tile"
import { TopRoastersTile } from "@/components/homeScreen/top-roasters-tile"
import { TimeSinceLastCoffeeTile } from "@/components/homeScreen/time-since-last-coffee"



export default function Page() {
  return (
    <div className="pl-16 pr-16 p-8">
      <div className="grid grid-cols-1 gap-3 landscape:grid-cols-2 md:grid-cols-2 lg:gap-4">
        <HeatmapTile></HeatmapTile>
        <TopBeansTile></TopBeansTile>
        <TopRoastersTile></TopRoastersTile>
        <TimeSinceLastCoffeeTile></TimeSinceLastCoffeeTile>
      </div>
    </div>

  )
}
