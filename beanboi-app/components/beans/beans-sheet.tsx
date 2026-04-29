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
import { Bean } from "lib/beans/types/bean"
import { useRouter } from "next/navigation"
import { updateBean, deleteBean, createBean} from "lib/beans/bean-api-client"

type BeanSheetProps = {
  bean: Bean
  isCreate: boolean
  children?: ReactNode
}

type EditableBeanFields = {
  name: string
  origin: string
  roaster: string
  roastDegree: number
  process: string
  altitude: string
}

export function BeanSheet({ bean, isCreate, children }: BeanSheetProps) {
  const router = useRouter()
  const [formData, setFormData] = useState<EditableBeanFields>({
    name: bean.name ?? "",
    origin: bean.origin ?? "",
    roaster: bean.roaster ?? "",
    roastDegree: bean.roastDegree ?? 0,
    process: bean.process ?? "",
    altitude: String(bean.altitude) ?? "",
  })
  const [newBeanData, setNewBeanData] = useState<EditableBeanFields>({
    name: "",
    origin: "",
    roaster: "",
    roastDegree: 0,
    process: "",
    altitude: "",
  })

  const rows = [
    { key: "name", label: "Name", value: isCreate ? newBeanData.name : formData.name, editable: true },
    { key: "origin", label: "Origin", value: isCreate ? newBeanData.origin : formData.origin, editable: true },
    { key: "roaster", label: "Roaster", value: isCreate ? newBeanData.roaster : formData.roaster, editable: true },
    { key: "roastDegree", label: "Roast", value: isCreate ? newBeanData.roastDegree : formData.roastDegree, editable: true },
    { key: "process", label: "Process", value: isCreate ? newBeanData.process : formData.process, editable: true },
    { key: "altitude", label: "Altitude", value: isCreate ? newBeanData.altitude : formData.altitude, editable: true },
    ...(!isCreate
      ? [
          { key: "price", label: "Price", value: bean.price, editable: false },
          { key: "timesPurchased", label: "Times Purchased", value: bean.timesPurchased, editable: false },
        ]
      : []),
  ] as const


  function onChange(field: keyof EditableBeanFields, value: string | number, isCreate: boolean) {
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

  async function onSubmit(formData: EditableBeanFields) {
    const updatedBean = { ...bean }
    const editableRows = rows.filter((row) => row.editable)
    editableRows.forEach((row) => {
        updatedBean[row.key] = formData[row.key]
      })

    await updateBean(updatedBean.id, updatedBean);
    router.refresh()
  }

  async function onCreate() {
    const bean : Bean = {
      name: newBeanData.name,
      origin: newBeanData.origin,
      roaster: newBeanData.roaster,
      roastDegree: newBeanData.roastDegree,
      process: newBeanData.process,
      altitude: Number(newBeanData.altitude),
      tastingNotes: "",
      price: 0,
      timesPurchased: 0,
      uid: "",
      isActive: true,
    }
    await createBean(bean);
    setNewBeanData({
      name: "",
      origin: "",
      roaster: "",
      roastDegree: 0,
      process: "",
      altitude: "",
    });
    router.refresh();
  }



  function onCancel(formData: EditableBeanFields) {
    const originalBean = { ...bean }
    const updatedFormData = { ...formData }
    const editableRows = rows.filter((row) => row.editable)
    editableRows.forEach((row) => {
        updatedFormData[row.key] = originalBean[row.key]
      })
    setFormData(updatedFormData)
  }

  async function onDelete(beanId: string) {
    console.log(beanId)
    await deleteBean(beanId)
    router.refresh()
  }


  function renderRow(row: {
     key: string
     label: string
     value: string | number
     editable: boolean
   }) {
     return (
       <TableRow key={row.key}>
         <TableCell>{row.label}</TableCell>
         <TableCell>
           {row.key === "roastDegree" ? (
             <Slider
               value={[Number(row.value)]}
               max={100}
               step={10}
               onValueChange={(value) => onChange("roastDegree", value[0], isCreate)}
             />
           ) : row.editable ? (
             <Input
               value={String(row.value)}
               onChange={(e) =>
                 onChange(row.key as keyof EditableBeanFields, e.target.value, isCreate)
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
           <Button variant="outline" className="capitalize">
             More Info
           </Button>
         )}
       </SheetTrigger>

       <SheetContent side="bottom" className="flex h-[50vh] flex-col">
         <SheetHeader>
           <SheetTitle>{isCreate ? "Create Bean" : formData.name}</SheetTitle>
         </SheetHeader>

         <div className="p-8">
           <Card className="bg-accent p-16 outline-accent">
             <Table>
               <TableCaption>More details on your bean.</TableCaption>
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

           {!isCreate && bean && (
             <SheetClose asChild>
               <Button variant="destructive" onClick={() => onDelete(bean.id)}>
                 Delete
               </Button>
             </SheetClose>
           )}
         </SheetFooter>
       </SheetContent>
     </Sheet>
   )
 }
