"use client"
import { Button } from "@/components/ui/button"
import { ReactNode, useState } from "react"
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet"
import { Card } from "@/components/ui/card"
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import { Input } from "@/components/ui/input"
import { Slider } from "@/components/ui/slider"
import { BeanPurchase } from "@/lib/beanPurchase/types/beanPurchase"
import { useRouter } from "next/navigation"
//import { updateBeanPurchase, deleteBeanPurchase, createBeanPurchase } from "lib/beanPurchase/bean-purchase-api-client"

type BeanPurchaseSheetProps = {
  purchase: BeanPurchase
  isCreate: boolean
  children?: ReactNode
}

type EditableBeanPurchaseFields = {
  name: string
  pricePaid: number
  amountPurchased: number
  amountRemaining: number
  purcahseDate: Date
  roastDate: Date
  beanId: string
}

export function PurchaseSheet({ purchase, isCreate, children }: BeanPurchaseSheetProps) {
  const router = useRouter()
  const [formData, setFormData] = useState<EditableBeanPurchaseFields>({
    name: purchase.name ?? "",
    pricePaid: purchase.pricePaid ?? 0,
    amountPurchased: purchase.amountPurchased ?? 0,
    amountRemaining: purchase.amountRemaining ?? 0,
    purcahseDate: purchase.purcahseDate ?? new Date(),
    roastDate: purchase.roastDate ?? new Date(),
    beanId: purchase.beanId ?? ""
  })

  const [newBeanData, setNewBeanData] = useState<EditableBeanPurchaseFields>({
    name: "",
    pricePaid: 0,
    amountPurchased: 0,
    amountRemaining: 0,
    purcahseDate: new Date(),
    roastDate: new Date(),
    beanId: ""
  })

  const rows = [
    { key: "name", label: "Name", value: isCreate ? newBeanData.name : formData.name, editable: true },
    { key: "pricePaid", label: "Price Paid", value: isCreate ? newBeanData.pricePaid : formData.pricePaid, editable: true },
    { key: "amountPurchased", label: "Amount Purchased", value: isCreate ? newBeanData.amountPurchased : formData.amountPurchased, editable: true },
    { key: "amountRemaining", label: "Amount Remaining", value: isCreate ? newBeanData.amountRemaining : formData.amountRemaining, editable: true },
    { key: "purcahseDate", label: "Purchase Date", value: isCreate ? newBeanData.purcahseDate : formData.purcahseDate, editable: true },
    { key: "roastDate", label: "Roast Date", value: isCreate ? newBeanData.roastDate : formData.roastDate, editable: true },
  ] as const

  function onChange(
    field: keyof EditableBeanPurchaseFields,
    value: string | number | Date,
    isCreate: boolean
  ) {
    if (isCreate) {
      setNewBeanData((prev) => ({
        ...prev,
        [field]: value,
      }))
      return
    } else {
      setFormData((prev) => ({
        ...prev,
        [field]: value,
      }))
    }
  }

  async function onSubmit(formData: EditableBeanPurchaseFields) {
    const updatedPurchase = { ...purchase }
    const editableRows = rows.filter((row) => row.editable)
    editableRows.forEach((row) => {
      //updatedPurchase[row.key] = formData[row.key]
    })

    //await updateBeanPurchase(purchase.id, updatedPurchase)
    router.refresh()
  }

  async function onCreate() {
    const purchase: BeanPurchase = {
      name: newBeanData.name,
      pricePaid: newBeanData.pricePaid,
      amountPurchased: newBeanData.amountPurchased,
      amountRemaining: newBeanData.amountRemaining,
      purcahseDate: newBeanData.purcahseDate,
      roastDate: newBeanData.roastDate,
      uid: "",
      beanId: newBeanData.beanId,
      isActive: true,
    }
    //await createBeanPurchase(purchase)
    setNewBeanData({
      name: "",
      pricePaid: 0,
      amountPurchased: 0,
      amountRemaining: 0,
      purcahseDate: new Date(),
      roastDate: new Date(),
      beanId: "",
    })
    router.refresh()
  }

  function onCancel(formData: EditableBeanPurchaseFields) {
    const originalPurchase = { ...purchase }
    const updatedFormData = { ...formData }
    const editableRows = rows.filter((row) => row.editable)
    editableRows.forEach((row) => {
      //updatedFormData[row.key] = originalPurchase[row.key]
    })
    setFormData(updatedFormData)
  }

  async function onDelete(purchaseId: string) {
    console.log(purchaseId)
    //await deleteBeanPurchase(purchaseId)
    router.refresh()
  }

  function renderRow(row: {
    key: string
    label: string
    value: string | number | Date
    editable: boolean
  }) {
    return (
      <TableRow key={row.key}>
        <TableCell>{row.label}</TableCell>
        <TableCell>
          {row.editable ? (
            <Input
              value={String(row.value)}
              onChange={(e) =>
                onChange(row.key as keyof EditableBeanPurchaseFields, e.target.value, isCreate)
              }
            />
          ) : (
            String(row.value)
          )}
        </TableCell>
      </TableRow>
    )
  }

  return (
    <Sheet>
      <SheetTrigger asChild>
        {children ?? (
          <Button className="w-full">
            Purchase
        </Button>
        )}
      </SheetTrigger>

      <SheetContent side="bottom" className="flex h-[50vh] flex-col">
        <SheetHeader>
          <SheetTitle>{isCreate ? "Create Purchase" : formData.name}</SheetTitle>
        </SheetHeader>

        <div className="p-8">
          <Card className="bg-accent p-16 outline-accent">
            <Table>
              <TableCaption>
                {isCreate ? "Create new purchase record" : "More details on your purchase."}
              </TableCaption>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-25">Property</TableHead>
                  <TableHead>Value</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>{rows.map(renderRow)}</TableBody>
            </Table>
          </Card>
        </div>

        <SheetFooter>
          <SheetClose asChild>
            <Button type="button" onClick={() => isCreate ? onCreate() : onSubmit(formData)}>
              {isCreate ? "Create" : "Save changes"}
            </Button>
          </SheetClose>

          <SheetClose asChild>
            <Button variant="outline" onClick={() => onCancel(formData)}>
              Cancel
            </Button>
          </SheetClose>

          {!isCreate && purchase && (
            <SheetClose asChild>
              <Button variant="destructive" onClick={() => onDelete(purchase.id)}>
                Delete
              </Button>
            </SheetClose>
          )}
        </SheetFooter>
      </SheetContent>
    </Sheet>
  )
}
