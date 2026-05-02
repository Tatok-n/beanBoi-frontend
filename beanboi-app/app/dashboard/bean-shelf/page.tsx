
import { BeanPurchase } from "@/lib/beanPurchase/types/beanPurchase"
import { getBeanPurchases } from "lib/beanPurchase/bean-purchase-api-server"
import { Card } from "@/components/ui/card"
import { CardContent, CardFooter, CardHeader } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { Button } from "@/components/ui/button"
import { getBeans } from "@/lib/beans/bean-api-server"
import { Bean } from "@/lib/beans/types/bean"

export default async function BeanShelfPage() {
  //const data = await getBeanPurchases()
  const beans = await getBeans();



  return (
    <div className="w-3/4 mx-auto flex flex-col items-center gap-6">
      <Card className="w-full max-w-4xl p-6">
        Current Stock
      </Card>

      <Card className="w-full max-w-4xl bg-muted p-6">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {beans.map((bean) => renderBeanTile(bean))}
        </div>
      </Card>
    </div>
  )
}


function renderBeanTile(bean: Bean) {
  return (
    <Card key={bean.name} className="h-full p-4">
        <CardHeader className="text-lg font-semibold">
          {bean.name}
        </CardHeader>

        <CardContent>
          ${bean.price}
        </CardContent>

        <CardFooter>
          <Button className="w-full">
            Purchase
          </Button>
        </CardFooter>
      </Card>
  )
}
