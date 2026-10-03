#import "letterhead.typ": *
#show: form.with(id: "bill-of-sale", from-court: false)

#align(center, text(font: DISPLAY, weight: 700, size: 14.5pt)[State of Louisiana])

#grid(columns: (1fr, 1fr), field[Parish of], field[Date])

*Before me*, the undersigned, in the parish and state named above, personally came and appeared:

#field[Seller]

of legal age, who by these presents sells, conveys, assigns, sets over, and delivers, with full warranty of title, to:

#field[Buyer]

of legal age, the following movable property:

#field[Serial number (VIN)]

#grid(columns: (2fr, 1fr), field[Make and model], field[Year])

The price of this movable property is the sum of:

#grid(columns: (3fr, 1fr), field[], field[dollars, \$])

paid in cash, the receipt of which the seller acknowledges.

The seller warrants that there are no mortgages, liens, or encumbrances of any kind against the movable property sold or any accessories attached to it.

#grid(
  columns: (1fr, 1fr),
  signature[Witness], signature[Signature of seller],
  signature[Witness], signature[Signature of buyer],
)

#field[Sworn to and subscribed before me on (date)]

#justice-signature
