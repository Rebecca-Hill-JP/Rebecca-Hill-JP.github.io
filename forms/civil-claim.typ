#import "letterhead.typ": *
#show: form.with(id: "civil-claim")

#caption()

== Plaintiff: the person or business making the claim

#field[Full name]

#field[Mailing address]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email])

== Defendant: the person or business you are suing

#field[Full name]

#field[Address where the defendant can be served]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email, if known])

#field[If a business, its agent for service (name and address)]

#note[More than one plaintiff or defendant? Give the same facts for each on a separate sheet.]

== The claim

#grid(columns: (2fr, 1fr), field[Amount claimed, in words], field[dollars: \$])

Plus, if claimed:
#h(0.8em) #check[Interest] #h(1.2em) #check[Court costs] #h(1.2em) #check[Attorney fees]

This suit is for (mark each that applies):

#checks([Past due rent], [Damage to rental property], [Promissory note])

#checks([Open account], [Money owed], [NSF check])

#item[Possession or ownership of movable property #h(1em) #field[Value \$]]

#item(field[Other])

#grid(columns: (1fr, 1fr), field[The debt or events began on (date)], field[and ended on (date)])

== What happened

State briefly what the claim is based on. Describe any promissory note or other written proof of the debt. For a claim to movable property, describe the property.

#lines(5)

== Attachments

Attach one copy of every document that supports your claim.

#item[Open account: a sworn statement that the account is correct is attached.]

#item[NSF check: a copy of the written demand and its certified mail receipt is attached.]

== Signature

The plaintiff affirms that the facts and documents submitted in this claim are true and accurate.

#grid(
  columns: (3fr, 2fr),
  signature[Signature of plaintiff or representative],
  signature[Date],
)

#field[Printed name]

#field[Name and address of attorney, if any]

#court-use[
  #grid(columns: (1fr, 1fr, 1fr), field[Date filed], field[Received by], field[Fee paid \$])
]
