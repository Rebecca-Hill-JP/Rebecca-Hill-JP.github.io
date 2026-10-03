#import "letterhead.typ": *
#show: form.with(id: "citation")

#caption()

#grid(
  columns: (1fr, 1fr),
  field[Plaintiff's address], field[Telephone],
  field[Defendant's address], field[Telephone],
)

== To the defendant named above

*You have been sued.* This lawsuit is filed in the Justice of the Peace Court named above. A copy of the plaintiff's petition is attached to this citation, with a true copy of all supporting documents submitted with the claim.

#item[You are cited to comply with the demand in the petition, or to file your answer and any exceptions you rely on with this court, within ten (10) days of service. To answer, use the form entitled "Defendant's Answer."]

#item[You are cited to appear for trial on (date) #blank(width: 9em) at (time) #blank(width: 5em) at #office.address.street, #office.address.city, Louisiana.]

*Your failure to comply will subject you to the penalty of entry of a default judgment against you.* If you are unsure of what to do, you should talk with an attorney about it immediately. C.C.P. arts. 4920, 4921, and 4921.1.

#field[Witness my hand on (date)]

#justice-signature
