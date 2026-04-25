import { Button } from "@/components/ui/button"
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetDescription,
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


import { Bean } from "lib/beans/types/bean"

type BeanSheetProps = {
  bean: Bean
}

export function BeanSheet({ bean }: BeanSheetProps) {
  return (
    <Sheet>
      <SheetTrigger asChild>
        <Button variant="outline" className="capitalize">
          More Info
        </Button>
      </SheetTrigger>
      <SheetContent
        side="bottom"
        className="flex h-[50vh] flex-col"
      >
        <SheetHeader>
          <SheetTitle>{bean.name}</SheetTitle>
        </SheetHeader>
        <div className="p-8">
          <Card className="p-16 bg-accent outline-accent" >
            <Table>
              <TableCaption>More details on your bean.</TableCaption>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-[100px]">Property</TableHead>
                  <TableHead>Value</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                <TableRow>
                  <TableCell className="font-medium">Name</TableCell>
                  <TableCell>{bean.name}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Origin</TableCell>
                  <TableCell>{bean.origin}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Roast</TableCell>
                  <TableCell>{bean.roastLevel}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Process</TableCell>
                  <TableCell>{bean.process}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Origin</TableCell>
                  <TableCell>{bean.origin}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Altitude</TableCell>
                  <TableCell>{bean.altitude}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Price</TableCell>
                  <TableCell>{bean.price}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Times Purchased</TableCell>
                  <TableCell>{bean.timesPurchased}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Roaster</TableCell>
                  <TableCell>{bean.roaser}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell className="font-medium">Active</TableCell>
                  <TableCell>{bean.isActive ? "Yes" : "No"}</TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </Card>
        </div>
        <SheetFooter>
          <Button type="submit">Save changes</Button>
          <SheetClose asChild>
            <Button variant="outline">Cancel</Button>
          </SheetClose>
        </SheetFooter>
      </SheetContent>
    </Sheet>
  )
}
