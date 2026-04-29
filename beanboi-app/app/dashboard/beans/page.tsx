import { columns } from "lib/beans/types/columns"
import { getBeans } from "lib/beans/bean-api-server"
import { DataTable } from "lib/beans/types/data-table"
import { Button } from "@/components/ui/button"
import { Plus } from "lucide-react"

export default async function BeanPage() {
  const data = await getBeans()

  return (
    <div>
      <div className="flex pt-4 pb-4 pr-4 justify-end" >
        <Button className="h-8 w-8">
          <Plus />
        </Button>
        </div>
        <DataTable columns={columns} data={data}/>
    </div>
  )
}
