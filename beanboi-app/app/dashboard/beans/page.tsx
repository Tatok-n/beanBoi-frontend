import { columns } from "lib/beans/types/columns"
import { getBeans } from "lib/beans/bean-api"
import { DataTable } from "lib/beans/types/data-table"

export default async function DemoPage() {
  const data = await getBeans()

  return (
    <div className="container mx-auto py-10">
      <DataTable columns={columns} data={data} />
    </div>
  )
}
