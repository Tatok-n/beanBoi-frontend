import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"
import { Card } from "@/components/ui/card"

const tileVariants = cva(
  "rounded-xl border accent text-card-foreground shadow-sm transition-colors",
  {
    variants: {
      variant: {
        default: "border-border",
        interactive: "border-border hover:bg-accent/40 hover:shadow-md cursor-pointer",
        selected: "border-primary ring-1 ring-primary/30",
        muted: "bg-muted/40 border-transparent shadow-none",
      },
      size: {
        sm: "p-8",
        md: "p-16",
        lg: "p-32",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "md",
    },
  }
)

export interface BaseTileProps
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof tileVariants> {}

export function BaseTile({
  className,
  variant,
  size,
  ...props
}: BaseTileProps) {
  return (
    <Card
      className={cn(tileVariants({ variant, size }), className)}
      {...props}
    />
  )
}
