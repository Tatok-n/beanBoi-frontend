"use client"

import { ColumnDef } from "@tanstack/react-table"
import { Bean } from "./bean"
import { BeanSheet } from "@/components/beans/beans-sheet"


export const columns: ColumnDef<Bean>[] = [
  {
    accessorKey: "name",
    header: "Name",
  },
  {
    accessorKey: "origin",
    header: "Origin",
  },
  {
    accessorKey: "roastLevel",
    header: "Roast Level",
  },
  {
      id: "actions",
      cell: ({ row }) => {
        const bean_row = row.original
        return (
          <BeanSheet bean={bean_row} isCreate={false} />
        )
      },
    },
]
