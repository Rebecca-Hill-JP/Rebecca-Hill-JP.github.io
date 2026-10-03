#import "letterhead.typ": *
#show: form.with(id: "ownership-judgment")

The court can render a judgment of ownership of a vehicle worth \$5,000 or less, on the applicant's sworn statement and the documents attached. The Office of Motor Vehicles sets its own requirements for issuing a title on a judgment, and a judgment does not guarantee a title. C.C.P. art. 4912; Office of Motor Vehicles Policy 3.00.

== Applicant: the person in possession of the vehicle

#field[Full name]

#field[Physical address]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email])

== The vehicle

#grid(columns: (1fr, 2fr, 2fr), field[Year], field[Make], field[Model])

#field[Vehicle identification number (VIN)]

#grid(columns: (1fr, 2fr), field[Value \$], field[Where the vehicle is kept])

== How you acquired it

#grid(columns: (1fr, 2fr), field[Date acquired], field[Consideration (money, trade, or other)])

#field[Acquired from (seller)]

#field[Seller's last known address]

Did the seller have a title in the seller's name? #h(0.8em) #check[Yes] #h(1.2em) #check[No]

Why you cannot get a title. Check each that applies:

#checks(
  [Bill of sale only; title promised, never delivered],
  [No longer in contact with the seller],
  [Seller never said where it was last titled],
  [Titled owner would not apply for a duplicate title],
  [Dealership out of business],
)

Explain fully how you acquired the vehicle and what happened.

#lines(4)

== Attached

#item[Bill of sale, if there is one]

#item[Title or certificate of registration, to verify the vehicle identification number]

#item[Affidavit of physical inspection, if there is no title or registration. The Office of Motor Vehicles requires the inspection to be made by a full-time P.O.S.T.-certified law enforcement officer certified by the Office of State Police to inspect motor vehicles.]

#item[Release of lien, if a lien is recorded]

== Oath

I swear that the statements in this application are true. To my knowledge no lien is recorded against the vehicle, or every recorded lien has been released and the release is attached.

#grid(
  columns: (3fr, 2fr),
  signature[Signature of applicant],
  signature[Date],
)

#field[Sworn to and subscribed before me on (date)]

#justice-signature

#court-use[
  #grid(columns: (1fr, 1fr, 1fr), field[Case No.], field[Date filed], field[Fee paid \$])
]

#order-page[Judgment]

On the applicant's sworn affidavit and the documents received, the court renders judgment under C.C.P. art. 4912 as follows.

+ #field[The current owner of the vehicle is]

+ #grid(columns: (2fr, 3fr), field[It was acquired on], field[for])

  #field[from]

  #field[whose last known address is]

+ #item[The vehicle is free of liens.]

  #item[A release of each recorded lien is attached.]

+ The vehicle is described as follows:

  #grid(columns: (1fr, 2fr, 2fr), field[Year], field[Make], field[Model])

  #field[Vehicle identification number (VIN)]

+ #block(breakable: false)[
    The nature of the acquisition, and the reason the papers needed to obtain a title are not available, are:

    #lines(2)
  ]

+ The value of the vehicle is \$ #blank(width: 6em), which does not exceed \$5,000. If a valuation guide gives a higher value, the facts that support the lower value are:

  #lines(1)

Judgment is rendered awarding ownership of the vehicle to the current owner named in item 1.

#grid(
  columns: (2fr, 3fr),
  signature[Date],
  justice-signature,
)
