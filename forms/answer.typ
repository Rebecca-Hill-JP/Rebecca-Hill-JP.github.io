#import "letterhead.typ": *
#show: form.with(id: "answer")

#caption()

Use this form to tell the court whether you contest the plaintiff's claim. Do not ignore the citation. If you do not answer or appear in time, the court may give a default judgment against you.

== Your answer

Mark the statement that applies.

#item[I do not owe the plaintiff any part of what is claimed.]

#item[I owe the plaintiff only part of what is claimed. #h(0.6em) #field[I agree that I owe \$]]

#item[I owe the plaintiff what is claimed.]

== Your reasons

Explain your answer.

#lines(6)

== Signature

#grid(
  columns: (3fr, 2fr),
  signature[Signature of defendant or representative],
  signature[Date],
)

#field[Printed name]

#field[Mailing address]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email])

#note[
  *Notice to all parties.* While this case is open, the court will contact you at the address and telephone number you gave. If either changes, tell the court at once.
]

#court-use[
  #grid(columns: (1fr, 1fr, 1fr), field[Date filed], field[Received by], field[Fee paid \$])
]
