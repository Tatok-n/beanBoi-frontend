import { columns } from "lib/beans/types/columns"
import { getBeans } from "lib/beans/bean-api-server"
import { DataTable } from "lib/beans/types/data-table"
import { Button } from "@/components/ui/button"
import { Plus } from "lucide-react"
import { BeanSheet } from "@/components/beans/beans-sheet"

export default async function BeanPage() {
  const data = await getBeans()
  const emptyBean: Bean = {
    id: "",
    name: "",
    tastingNotes: "",
    roaster: "",
    process: "",
    origin: "",
    roastDegree: 0,
    altitude: 0,
    price: 0,
    timesPurchased: 0,
    uid: "",
    isActive: false,
  }

  return (
    <div>
      <div className="flex pt-4 pb-4 justify-start">
        <BeanSheet bean={emptyBean} isCreate={true}>
          <Button className="h-8 w-8">
            <Plus />
          </Button>
        </BeanSheet>
      </div>

      <DataTable columns={columns} data={data} />
    </div>
  )
}
