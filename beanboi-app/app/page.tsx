import { Button } from "@/components/ui/button"
import { BaseTile } from "@/components/homeScreen/tile"


export default function Page() {
  return (
    <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
      <BaseTile>Heatmap of coffee</BaseTile>
      <BaseTile>Top Beans</BaseTile>
      <BaseTile>Top roasters</BaseTile>
      <BaseTile>Time since last coffee</BaseTile>
    </div>
  )
}
