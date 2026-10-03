#import "letterhead.typ": *
#show: form.with(id: "citation-return")
#set text(size: 11pt)

#caption()

#field[Citation and certified copy of petition received on (date)]

Mark the one that applies.

#item[*Personal.* I served them on the defendant by delivering them to the defendant in person.
  #grid(columns: (1fr, 2fr, 1fr), field[On (date)], field[at], field[Parish])]

#item[*Domiciliary.* I served them on the defendant by delivering them at the defendant's dwelling house or usual place of abode to a person of suitable age and discretion residing there, whose name and other facts connected with this service I learned by questioning that person, the defendant being temporarily absent from the domicile at the time of service.
  #grid(columns: (1fr, 2fr, 1fr), field[On (date)], field[at], field[Parish])
  #field[Delivered to]]

#item[*Certified mail, return receipt.* I mailed them to the defendant by certified mail, return receipt requested, and received the return receipt from the U.S. Postal Service.
  #grid(columns: (1fr, 2fr), field[Mailed on (date)], field[to])
  #field[Receipt received on (date)]
  #grid(columns: (2fr, 1fr), field[signed by], field[dated])]

#item[*Due diligence.* After diligent search and inquiry, I was unable to find the defendant, the defendant's domicile, or anyone legally authorized to represent the defendant. I return the citation or other process and the accompanying petition *not served*.
  #grid(columns: (1fr, 2fr), field[On (date)], field[for these reasons])]

#signature[Constable, #court]
