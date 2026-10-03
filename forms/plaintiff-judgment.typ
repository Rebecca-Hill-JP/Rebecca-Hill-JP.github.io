#import "letterhead.typ": *
#show: form.with(id: "plaintiff-judgment")

#caption()

This case came on for trial as previously assigned, and both parties appeared in court at the hour fixed for trial. The plaintiff proved the demand, and the law and evidence are in favor of the plaintiff and against the defendant.

*It is therefore ordered, adjudged, and decreed* that there be judgment in favor of the plaintiff:

#field[]

and against the defendant:

#field[]

in the sum of:

#grid(columns: (3fr, 1fr), field[], field[dollars, \$])

#field[with interest at #blank(width: 3em) percent from (date)]

until paid, plus court costs.

#field[*Judgment read, rendered, and signed* in open court on (date)]

#justice-signature
