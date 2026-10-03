#import "letterhead.typ": *
#show: form.with(id: "answer")

#caption()

Use this form to tell the court whether you contest the plaintiff's claim. Do not ignore the citation. If you do not answer within 10 days after the citation is served, or appear on the trial date it gives, the court may give a default judgment against you.

Include every defense you have. File your answer with the court and mail a copy to the plaintiff; regular mail is fine.

If you have a claim of your own against the plaintiff, you may file a reconventional demand. The plaintiff must be served with it before the trial. Ask the office.

== Your answer

Mark the statement that applies, explain your answer below, or both.

#item[I do not owe the plaintiff any part of what is claimed.]

#item[I owe the plaintiff only part of what is claimed. #h(0.6em) #field[I agree that I owe \$]]

#item[I owe the plaintiff what is claimed. I waive any further appearance and delays, and consent to judgment against me in the amount claimed.]

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
