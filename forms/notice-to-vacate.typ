#import "letterhead.typ": *
#show: form.with(id: "notice-to-vacate", from-court: false)

#align(center)[This notice is from the landlord or owner named below. It is not a court order.]

#grid(columns: (1fr, 2fr), field[Date], [])

#field[To (every tenant or occupant)]

#field[Address of the premises]

== Notice

*You are hereby notified to vacate the premises at the address above within five (5) days of the delivery of this notice to you.*

#item[*Tenant.* Your right to occupy the premises has ended because:]

#pad(left: 1.6em)[
  #checks([Rent has not been paid], [The lease term has ended])

  #item(field[Other violation of the lease])

  #grid(columns: (1fr, 1fr), field[Date of the lease, if known], [#check[Written] #h(1em) #check[Verbal]])
]

#item[*Occupant who is not a tenant.* The purpose of your occupancy has ceased because:]

#lines(2)

Should you fail to vacate within this period, court proceedings will be taken immediately to evict you from the premises under the Louisiana Code of Civil Procedure.

== Landlord or owner

#grid(
  columns: (3fr, 2fr),
  signature[Signature of landlord, owner, or agent],
  signature[Telephone],
)

#field[Printed name]

#field[Mailing address]

#grid(columns: (1fr, 1fr), signature[Witness], signature[Witness])

#pagebreak()

== Landlord's record of delivery

Keep this page with a copy of the notice. Do not give it to the tenant or occupant. The court will ask how and when the notice was delivered.

#field[Notice to (name)]

#grid(columns: (1fr, 1fr), field[Date delivered], field[Delivered by])

#item(field[Handed to])

#item[Sent by certified mail (keep the receipt)]

#item[Attached to a door of the premises, because the premises are abandoned or closed, or the whereabouts of the tenant or occupant is unknown]

#note[
  The five days do not include the day of delivery, Saturdays, Sundays, or legal holidays. C.C.P. arts. 4701, 4702, and 5059; R.S. 1:55.
]
