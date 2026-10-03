#import "letterhead.typ": *
#show: form.with(id: "eviction-petition")

#caption(first: "Plaintiff(s): landlord or owner", second: "Defendant(s): tenant or occupant")

== Plaintiff

#field[Full name]

#field[Mailing address]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email])

== Defendant

#field[Full name of every tenant or occupant]

#grid(columns: (1fr, 1fr), field[Telephone, if known], field[Email, if known])

== The premises

#field[Address, in Ward 10]

#grid(
  columns: (auto, 1fr),
  checks([a home], [business premises or farmland]),
  field[Monthly rent \$],
)

== Grounds for eviction

The defendant is:

#checks([a tenant, written lease], [a tenant, verbal agreement], [an occupant, not a tenant])

#block(breakable: false)[
  The reason for eviction is:

  #checks([Rent has not been paid], [Damage to the property], [The lease term has ended])

  #item(field[Other])

  Explain:

  #lines(2)
]

== Notice to vacate

#item[The defendant waived the five-day notice to vacate in the written lease.]

#item[The plaintiff gave written notice to vacate #h(0.4em) #field[on (date)]]

#pad(left: 1.6em)[
  #item[handed to the defendant, witnessed]

  #item[sent by certified mail; the receipt is attached]

  #item[posted on a door, witnessed (if abandoned, closed, or whereabouts unknown)]
]

#item[The time allowed by the notice has ended and the defendant has not vacated.]

Attached:
#h(0.6em) #check[a copy of the notice to vacate] #h(1.2em) #check[two copies of the lease]

== Request

The plaintiff has followed the eviction laws of Louisiana as marked above, and asks that the defendant be ordered to show cause why the defendant should not vacate and deliver possession to the plaintiff, with costs.

#grid(
  columns: (3fr, 2fr),
  signature[Signature of plaintiff or representative],
  signature[Date],
)

#field[Printed name]

#court-use[
  #grid(columns: (1fr, 1fr, 1fr), field[Date filed], field[Received by], field[Fee paid \$])
  #grid(columns: (1fr, 1fr), field[Hearing date], field[Time])
]
