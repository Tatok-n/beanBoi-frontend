import { columns } from "lib/beans/types/columns"
import { getBeans } from "lib/beans/bean-api-server"
import { DataTable } from "lib/beans/types/data-table"

export default async function BeanPage() {
  const data = await getBeans()

  return (
    <div className="container mx-auto py-10">
      <DataTable columns={columns} data={data}/>
    </div>
  )
}
