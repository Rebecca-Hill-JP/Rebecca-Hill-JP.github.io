#import "letterhead.typ": *
#show: form.with(id: "wedding-request")

Use this form to ask the Justice of the Peace to perform your marriage ceremony. The office will contact you to confirm the date, time, and place.

== The couple

Give each name exactly as it appears on the marriage license.

#field[Full name]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email])

#field[Full name]

#grid(columns: (1fr, 1fr), field[Telephone], field[Email])

== The ceremony

#grid(columns: (1fr, 1fr), field[Date requested], field[Time])

#grid(columns: (1fr, 1fr), field[Second choice of date], field[Time])

Place:
#h(0.6em) #check[the office of the Justice of the Peace] #h(1.2em) #check[another place:]

#field[Address]

#field[Number of guests]

== The marriage license

The ceremony cannot take place until 24 hours after the license is issued, and must take place within 30 days. Bring the license to the ceremony.

#check[We have our license.] #h(1.2em) #check[We will have our license before the ceremony.]

#grid(columns: (1fr, 1fr), field[Parish that issued it], field[Date and time issued])

== Witnesses

The law requires two adult witnesses at the ceremony.

#field[Witness, full name]

#field[Witness, full name]

== Anything else the office should know

#lines(3)

#grid(
  columns: (3fr, 2fr),
  signature[Signature],
  signature[Date],
)

#note[
  R.S. 9:205, 9:235, 9:241, and 9:244.
]
