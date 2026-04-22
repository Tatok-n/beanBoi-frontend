import { Button } from "@/components/ui/button"
import { BaseTile } from "@/components/homeScreen/tile"
import Heatmap from "@/components/ui/heatmap"
import { HeatmapTile } from "@/components/homeScreen/heatmaptile"


export default function Page() {
  return (
    <div className="pl-16 pr-16 p-8">
      <div className="grid grid-cols-1 gap-3 landscape:grid-cols-2 md:grid-cols-2 lg:gap-4">
        <HeatmapTile></HeatmapTile>
        <BaseTile className="aspect-square">Top Beans</BaseTile>
          <BaseTile className="aspect-square">Top roasters</BaseTile>
          <BaseTile className="aspect-square">Time since last coffee</BaseTile>
        </div>
    </div>

  )
}
