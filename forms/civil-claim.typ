#import "letterhead.typ": *

// The fees are those the website lists, read from the page's front matter.
#let small-claims = yaml(bytes(read("/src/content/services/small-claims.md").split("---").at(1)))

#let instructions = [
  #set text(size: 11pt)
  #set par(spacing: 1em)

  Read this page before you start. Keep it; file only the pages that follow.

  == The defendant

  *Name.* Give the full name of each person you sue. For a business, give its exact legal name. Corporations and limited liability companies are listed in the Louisiana Secretary of State's business search at sos.la.gov.

  *Address.* The court's papers are served on the defendant at the address you give. A home address is best: if the defendant is out, the papers may be left with a person of suitable age and discretion who lives there. At any other address, such as a workplace, they must be handed to the defendant. C.C.P. arts. 1232 and 1234.

  *A corporation or limited liability company* is served through its registered agent for service of process. Give the agent's name and address from the Secretary of State's listing. C.C.P. arts. 1261 and 1266.

  == The claim

  *Amount.* Write it in words and in figures. Mark interest, court costs, or attorney fees only if you claim them; they do not count toward the \$5,000 limit. C.C.P. art. 4911.

  *What happened.* In your own words: who did what, when, and how you worked out the amount. Describe any note, contract, lease, or invoice. For a claim to property, describe the property and give its value.

  *Attachments.* Attach one copy of each paper that supports your claim. Keep the originals and bring them to the trial. For an open account, attach a statement of the account sworn before a notary. For a returned check, attach your written demand for payment and its certified mail receipt.

  == Sign and file

  Sign, date, and print your name. Your signature affirms that the facts and papers are true.

  #office.how_to_file Telephone #office.phone.

  *Fees.* #small-claims.fees.filter(fee => fee.amount.starts-with("$")).map(fee => [#fee.item: #fee.amount.]).join(" ") Pay by #office.payment_methods; make checks payable to #office.payable_to. If you cannot afford the costs, ask the office about going forward without paying in advance. C.C.P. arts. 5181 through 5188.

  A judgment says who owes what; it does not collect the money.
]

#show: form.with(id: "civil-claim", instructions: instructions)

#caption()

== Plaintiff: the person or business making the claim

#field[Full name]

#field[Mailing address]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email])

== Defendant: the person or business you are suing

#field[Full name]

#field[Address where the defendant can be served]
#lines(1)

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
