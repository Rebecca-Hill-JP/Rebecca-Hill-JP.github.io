# Form sources

Each form here is the court's own. Louisiana law does not require a set form in
a justice of the peace court: "A party or his attorney may state the claim,
exceptions, defenses, or other pleas orally to the justice of the peace or the
clerk of court. No written pleadings shall be required."
([C.C.P. art. 4917](https://legis.la.gov/Legis/Law.aspx?d=112124)). The forms
therefore only need to capture what the law and the baseline forms capture.
This file records that comparison, field by field.

Rule, set by the office: where the Attorney General publishes a sample form,
our form follows its procedure. A legal concern about a sample is recorded
here, not designed into the form.

Status: drafted from the baselines below and adjusted to the office's answers
to the intake questionnaire (2026-10-02). Not yet compared with the forms the
office uses today, and not yet reviewed by the Justice of the Peace.

## Baselines

| Key | Source                                                                                                                                                                                                                                                    |
| --- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AG  | Louisiana Attorney General justice court training forms ("Forms From 2015 DVD"), numbered as on the index at http://www.lajpc2.com/forms/index.html. A justice of the peace's mirror of Attorney General training material, not an Attorney General page. |
| MAN | Forms of the Ward 4 Justice of the Peace Court, St. Tammany Parish (mandevillejustice.com). One court's practice, not a standard.                                                                                                                         |
| JCM | Justice Court Manual, 7th edition, Louisiana Department of Justice. http://www.lajpc2.com/manual/Justice%20Court%20Manual%207th%20Edition.pdf                                                                                                             |
| Law | Statute text on legis.la.gov, read 2026-10-02.                                                                                                                                                                                                            |

Not obtained: the office's current forms (requested in the intake questionnaire),
and the forms on lajpctraining.com (behind a login).

## Statement of Claim (`civil-claim.typ`)

Baselines: AG 04 "Statement of Claim"; MAN "Statement of Claim".

| Our field                                                              | AG 04                                                                                                                                                     | MAN                                                                   | Law                                                                      |
| ---------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| Case No.                                                               | Case No.                                                                                                                                                  | Case No.                                                              | art. 4918, docket number                                                 |
| Court, ward, parish, state (printed)                                   | blanks for ward, district, parish, court address and telephone                                                                                            | printed caption                                                       | art. 4919(A)(4)                                                          |
| Plaintiff name, address                                                | Plaintiff(s), Address                                                                                                                                     | Plaintiff(s), Address                                                 | art. 4918, name and address of all parties                               |
| Plaintiff telephone, email                                             | Business No., Fax No.                                                                                                                                     | Plaintiff's Email Address                                             |                                                                          |
| Defendant name, address for service                                    | Defendant, Address                                                                                                                                        | Defendant(s), Address; "address where the Defendant(s) may be served" | art. 4918                                                                |
| Defendant telephone, email                                             | Business No., Residence No.                                                                                                                               |                                                                       |                                                                          |
| Agent for service of a business                                        |                                                                                                                                                           | "you will need to Serve the Registered Agent"                         |                                                                          |
| Amount in words and figures                                            | "SUIT AMOUNT ... DOLLARS ($ ...)"                                                                                                                         | "I am seeking the following compensation"                             | art. 4918, amount of the claim; art. 4919(C)(1)                          |
| Interest, court costs, attorney fees                                   | "PLUS: Interest, Court Cost, Legal Attorney Fees"                                                                                                         | "(plus Court costs)"                                                  | art. 4911(B), not counted toward the limit                               |
| Kind of suit checkboxes                                                | Damages to Rental Property, Past Due Rent, Promissory Note, NSF Check, Open Account, Money Claim, Other                                                   |                                                                       | art. 4918, nature of the claim                                           |
| Movable property, value                                                |                                                                                                                                                           |                                                                       | art. 4912(A); art. 4919(C)(2), describe the property and state its value |
| Dates the debt or events began and ended                               | "Date Indebtedness Occurred ... thru ..."                                                                                                                 | "These events took place on (Date)"                                   | art. 4919(C)(1), year or years in which the indebtedness arose           |
| What happened; describe note or written proof                          | "attach written explanation of claim"                                                                                                                     | "This is a suit based upon the following"                             | art. 4919(C)(1), describe any promissory note or other written evidence  |
| One copy of documents (the office asks for one)                        | "Please attach two copies of any written documents"                                                                                                       | "TWO (2) COPIES of all documents" (instructions)                      |                                                                          |
| Open account sworn statement; proof copies were sent by certified mail | "certification of the correctness of the account ... signed in Notary's presence, with documentation that Defendant(s) was sent copies by certified mail" |                                                                       | art. 4921(B), proof by affidavit                                         |
| NSF check: certified mail receipt for the 30-day demand                | "Copy attached of certified receipt which has given Defendant(s) 30 days"                                                                                 |                                                                       |                                                                          |
| Affirmation                                                            | "Plaintiff(s) affirms that the facts and documents as submitted in this claim are true and accurate."                                                     | same words                                                            |                                                                          |
| Signature, printed name, date                                          | Signature of Plaintiff or Representative                                                                                                                  | Signature of Plaintiff or Representative                              |                                                                          |
| Attorney name and address                                              | "Name and Address of Attorney if appropriate"                                                                                                             |                                                                       |                                                                          |
| Court use: date filed, received by, fee                                | "DATE FILED"                                                                                                                                              | "CLERK", "FILED"                                                      |                                                                          |

Left out on purpose:

- "District" in the AG caption. Ward 10 has two justices of the peace. Whether
  this court has a district or division name to print in the caption is an
  open question for the office.

### Instruction page

The first page, kept by the filer, follows MAN's "Instructions for Filing
Suit" in purpose but not in wording. Each legal statement rests on the article
it cites: service at home or in person (arts. 1232, 1234), service on a
corporation or limited liability company through its registered agent
(arts. 1261, 1266), the $5,000 limit (art. 4911), and costs paid in advance
(arts. 5181 to 5188). Fees, payment, and how to file come from `site.toml` and
the small claims page, so the form cannot disagree with the website.

Left out of MAN's instructions on purpose:

- "The Statute of Limitation for Filing a Civil Suit (Small Claims) is one year
  from the date of the last activity on the account." No single period applies
  to small claims; it depends on the kind of claim, and none of the periods was
  checked.
- Office rules of that court: two copies of each document, no documents accepted
  after filing, $50 for each extra service address, waiting four weeks before
  calling. This office has not said it has such rules.
- The 15-day appeal and that either side may have a lawyer. Both are on the
  website; neither helps fill out the form.

## Defendant's Answer (`answer.typ`)

Baselines: AG 09 "Defendant's Answer"; AG 08 "Instructions for Defendant's Answer". MAN has no answer form.

| Our field                                                                                           | AG 09 / 08                                                                      | Law                                        |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------ |
| Caption, Case No.                                                                                   | caption, Case No.                                                               |                                            |
| Warning not to ignore the citation; answer within 10 days or appear on the trial date               | 08: "DO NOT IGNORE THESE PAPERS"; "within ten (10) calendar days after service" | art. 4920; art. 4921, default judgment     |
| Include every defense; mail a copy to the plaintiff                                                 | 08: "every 'defense' you have"; "mail a copy of your answer to the plaintiff"   |                                            |
| Reconventional demand, served before trial                                                          | 08 item 4                                                                       |                                            |
| Mark a statement, explain, or both                                                                  | 09: "Mark the statement below that applies and/or provide a narrative answer"   |                                            |
| "I do not owe the plaintiff any part of what is claimed"                                            | 09 statement 1                                                                  |                                            |
| "I owe the plaintiff only part of what is claimed", amount admitted                                 | 09 statement 2 (amount is our addition)                                         |                                            |
| "I owe the plaintiff what is claimed", waiver of further appearance and delays, consent to judgment | 09 statement 3                                                                  |                                            |
| Reasons                                                                                             | 09 six blank lines; 08: "Your answer should contain every 'defense' you have"   | art. 4917(C), all exceptions in the answer |
| Signature, date, printed name, address, telephone, email                                            | Date, Signature, Phone No., Address                                             |                                            |
| Notice to all parties about change of address                                                       | 09 "NOTICE TO ALL PARTIES"                                                      |                                            |
| Court use                                                                                           |                                                                                 |                                            |

Left out on purpose: the list of example defenses in AG 08. It is
instruction, and listing defenses comes close to legal advice.

Concerns from the independent legal review of 2026-10-02, kept on record now
that the form follows AG 08 and 09: the consent to judgment is a legal act the
form does not explain; no article in C.C.P. arts. 4917 to 4921.1 requires
mailing a copy of the answer to the plaintiff, and an answer may be oral;
art. 4917(C) speaks only of exceptions, not every defense.

## Notice to Vacate (`notice-to-vacate.typ`)

Baselines: AG 41 "Notice to Vacate (Tenant)"; AG 42 "Notice to Vacate (Occupant)"; MAN "Notice to Vacate".

One form covers both the tenant and the occupant notice, chosen by checkbox.
It carries no court letterhead, and says at the top and in the footer that the
court did not issue it: the notice comes from the landlord
([art. 4701](https://legis.la.gov/Legis/Law.aspx?d=112073), "the lessor or his
agent shall cause written notice to vacate the premises to be delivered").

| Our field                                                                                                    | AG 41 / 42                                   | MAN                                                                  | Law                                                                       |
| ------------------------------------------------------------------------------------------------------------ | -------------------------------------------- | -------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| Date                                                                                                         | Date                                         | Date                                                                 |                                                                           |
| To; address of the premises                                                                                  | To (three lines)                             | To; Address                                                          |                                                                           |
| "You are hereby notified to vacate ... within five (5) days of the delivery of this notice to you"           | 41, same words                               | same words                                                           | art. 4701, not less than five days from delivery; art. 4702, five days    |
| Tenant: reason (rent, term ended, other violation)                                                           | 41: "your lease was terminated when you ..." | Non-payment of rent; Non-payment of rental deposit; Other violations | JCM p. 151: "The notice to vacate should state the reasons for eviction." |
| Date of lease; written or verbal                                                                             |                                              | "Pursuant to a written or verbal lease dated ..."                    |                                                                           |
| Occupant: "the purpose of your occupancy ... has ceased because"                                             | 42, same words                               |                                                                      | art. 4702                                                                 |
| "Should you fail to vacate within this period, court proceedings will be taken immediately to evict you ..." | 41 and 42                                    | same                                                                 |                                                                           |
| Landlord signature, printed name, address, telephone                                                         | Owner/Landlord                               | Lessor                                                               |                                                                           |
| Two witnesses (the law requires none; review 2026-10-02)                                                     | 41                                           |                                                                      |                                                                           |
| Page 2, landlord's record of delivery                                                                        | AG 43 asks how the notice was delivered      | MAN petition asks the same                                           | art. 4703, attaching to the door                                          |
| Note on counting the five days: not the day of delivery, Saturdays, Sundays, or legal holidays               |                                              |                                                                      | art. 5059; R.S. 1:55(E)(3); JCM p. 151                                    |

Left out on purpose: MAN's "Non-payment of rental deposit" checkbox; it is covered by "Other violation of the lease".

## Petition of Eviction (`eviction-petition.typ`)

Baselines: AG 43 "Petition of Eviction"; MAN "Petition of Eviction and Order".

| Our field                                                                                     | AG 43                                                                                           | MAN                                                         | Law                                                                   |
| --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | --------------------------------------------------------------------- |
| Caption, Case No.                                                                             | caption                                                                                         | caption, Case No., Date Filed                               |                                                                       |
| Plaintiff name, address, telephone, email                                                     | name line only                                                                                  | Plaintiff(s), Email, Address, Cell No., Other No.           |                                                                       |
| Defendant names, telephone, email                                                             | name line only                                                                                  | Defendant(s), Email, Cell No., Other No.                    |                                                                       |
| Address of the premises, in Ward 10                                                           | "the premises described above"                                                                  | defendant address lines                                     | art. 4912(A)(1), within its territorial jurisdiction                  |
| Home, or business premises or farmland; monthly rent                                          |                                                                                                 |                                                             | art. 4912(B), commercial and farm rent limit                          |
| Defendant is a tenant (written, verbal) or an occupant                                        | Written Lease, Written Rental Agreement, Verbal Agreement                                       | Written Lease, Oral Lease                                   | arts. 4701, 4702                                                      |
| Reason: rent, damage, term ended, other; explanation                                          | Non-Payment of Rent, Damage to Property, Other Violations; Explanations                         | Non-Payment of Items, Damages to Property, Other Violations | art. 4731(A), "shall state the grounds upon which eviction is sought" |
| Notice waived in the written lease                                                            | "waiver of five (5) day notice to vacate in the Rental Agreement"                               | same                                                        | art. 4701                                                             |
| Notice given, date, and how delivered, witnessed; the door box states the art. 4703 condition | hand delivered with a witness; certified mail; posted on door with a witness                    | hand delivered or placed on or near door                    | arts. 4701, 4703                                                      |
| Notice period ended, defendant has not vacated                                                |                                                                                                 |                                                             | art. 4731(A), "fails to comply with the notice to vacate"             |
| "The plaintiff has followed the eviction laws of Louisiana as marked above"                   | "abided by the Eviction Laws of the State of Louisiana by fulfilling requirements as indicated" |                                                             |                                                                       |
| Copies attached: notice, two of the lease (office practice)                                   | both                                                                                            | both                                                        |                                                                       |
| Request for rule to show cause, possession, costs                                             | "WHEREFORE, plaintiff(s) prays ..."                                                             | same in substance                                           | art. 4731(A)                                                          |
| Signature, printed name, date                                                                 | Signature of Plaintiff(s) or Representative                                                     | same                                                        |                                                                       |
| Court use: date filed, hearing date and time                                                  | Date Filed with the Court                                                                       | Court date                                                  | art. 4732(A)                                                          |

Left out on purpose:

- MAN's "Attorney's fees are awarded in the amount of $". It reads as a ruling inside the plaintiff's own petition.
- AG 43's separate "Written Rental Agreement" box; merged with "written lease".
- The order to show cause (AG 44) and the constable's return (AG 48). MAN prints
  them on the petition. They are the court's papers, not the party's, so they
  are not on this form. The office keeps them separate; the order is the
  office form "Rule to Show Cause: Eviction".

## Wedding Request (`wedding-request.typ`)

No baseline: none of the sources above publishes a wedding form. This is an office
scheduling form, not a legal document. The facts it states come from statute:

| Our text or field                     | Law                                                  |
| ------------------------------------- | ---------------------------------------------------- |
| License required at the ceremony      | R.S. 9:205                                           |
| 24 hours after the license is issued  | R.S. 9:241                                           |
| Within 30 days                        | R.S. 9:235                                           |
| Parish of issue, date and time issued | R.S. 9:234, time and date on the face of the license |
| Two adult witnesses                   | R.S. 9:244, "two competent witnesses of full age"    |

## Waiver of the 24-Hour Delay (`delay-waiver.typ`)

No baseline form. The Attorney General's index has no marriage forms. Built
from the statute and checked by the independent review of 2026-10-02
(`law/review-forms-2026-10-02.md`).

| Our text or field                                                   | Law                                                                                     |
| ------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| No ceremony until 24 hours after the license is issued              | R.S. 9:241                                                                              |
| Application of the parties, with their reasons                      | R.S. 9:242(A), "upon application of the parties giving serious and meritorious reasons" |
| Certificate waiving the delay and authorizing immediate performance | R.S. 9:242(A), "His certificate authorizing the immediate performance of the ceremony"  |
| "This certificate must be attached to the marriage license"         | R.S. 9:242(A), same words                                                               |

The certificate names the couple so it still identifies them once attached to
the license. It does not recite that the justice is authorized to perform the
marriage; the review found that recital true but not required.

## Waiver of Birth Certificate (`birth-certificate-waiver.typ`)

No baseline form. Built from the statute and checked by the same review.

| Our text or field                                                    | Law                                                                                            |
| -------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Applicant born in a state or territory of the United States          | R.S. 9:228(B), "born in any state or territory of the United States"                           |
| Letter from the registration authority that no record was found      | R.S. 9:227(A)                                                                                  |
| Other proof of the facts of birth                                    | R.S. 9:227(C), "shall demand other proof of birth facts"                                       |
| Order: extenuating circumstances, good cause, after a hearing        | R.S. 9:228(B)                                                                                  |
| Order: finding that the parties complied with all other requirements | R.S. 9:228(B)                                                                                  |
| Order directed to the official who issues licenses in the parish     | R.S. 9:228(B), "an issuing official within the parish where his court is situated"; R.S. 9:221 |
| "This order must be attached to the marriage application"            | R.S. 9:228(B)                                                                                  |

The order is on its own page under the letterhead so it can be attached to the
license application. The law gives no power to waive the birth certificate of
an applicant born outside the United States (R.S. 9:226(C)); the form says
nothing about that case.

## Judgment of Ownership of a Vehicle (`ownership-judgment.typ`)

Baselines: the Attorney General's "Court Order" and "Affidavit of Applicant"
(JCM p. 234 and the forms index), the Office of Motor Vehicles "Request for
Review Prior to Judgment" (JCM p. 233), and Office of Motor Vehicles Policy
3.00, "Justice of the Peace Court Orders" (revised 2024-06-17).

| Our field                                                                            | AG sample                                                 | OMV                                                                   | Law                                  |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------ |
| Applicant name, address                                                              | "Applicant"; current owner                                | name of applicant (owner in possession); physical address             | art. 4912(A)(1)                      |
| Year, make, model, VIN                                                               | same                                                      | same                                                                  |                                      |
| Value; where the vehicle is kept                                                     |                                                           | value under $5,000, with facts if a guide says more                   | art. 4912(A)(1), value and territory |
| Date acquired; consideration                                                         | date acquired; price                                      | same                                                                  |                                      |
| Seller and last known address                                                        | same                                                      | same                                                                  |                                      |
| Did the seller have proof of ownership                                               |                                                           | Request for Review, item 4                                            |                                      |
| Reasons title papers are unavailable, as tick boxes                                  |                                                           | Request for Review, item 5                                            |                                      |
| How acquired, explained                                                              | "Nature of Acquisition"                                   | same                                                                  |                                      |
| Attachments: bill of sale, title or registration, inspection affidavit, lien release |                                                           | same                                                                  |                                      |
| Oath before the Justice of the Peace                                                 | "Sworn to and subscribed before me"                       |                                                                       | R.S. 13:2586.1(A)(1), (E)            |
| Judgment on the affidavit and documents, no defendant                                | "upon receipt of proper documents and attached affidavit" |                                                                       | art. 4912                            |
| Judgment: lien findings as tick boxes                                                | "the vehicle is lien free"                                | "must state that the vehicle is lien free", or a satisfaction of lien | R.S. 32:712                          |
| Judgment: value, with facts if a guide says more                                     |                                                           | same                                                                  |                                      |
| Judgment on letterhead, signed and dated                                             | letterhead block                                          | "on letterhead"                                                       | art. 4923                            |

Follows the Attorney General's sample: judgment on the applicant's affidavit,
with no defendant. The independent review read the Code otherwise: art. 4912
gives jurisdiction over "suits", art. 1201(A) makes citation and service
essential ("Without them all proceedings are absolutely null"), art.
4913(B)(9) denies jurisdiction over in rem proceedings, and OMV Policy 3.00
says adversarial proceedings "must be against the owner of record". If those
hold, a judgment without a served defendant could later be attacked as null.
The office chose the sample (2026-10-02).

## Bill of Sale (`bill-of-sale.typ`)

Baseline: AG 61 "Bill of Sale". An office form: the parties sign before the
Justice of the Peace as ex officio notary. No letterhead, because the act is
the parties', not the court's.

| Our field                                                       | AG 61 |
| --------------------------------------------------------------- | ----- |
| State of Louisiana; parish; date                                | same  |
| "Before me ... personally came and appeared": seller            | same  |
| Sells "with full warranty of title" to the buyer, both of age   | same  |
| Serial number (VIN); make and model; year                       | same  |
| Price in words and figures, cash, receipt acknowledged          | same  |
| Seller warrants no mortgages, liens, or encumbrances            | same  |
| Two witnesses; seller and buyer sign                            | same  |
| "Sworn to and subscribed before me"; Justice of the Peace signs | same  |

Concern on record: an ex officio notary may not draft documents
(R.S. 13:2586.1). Whether completing a printed bill of sale for the parties
is drafting is the office's call; the office uses this form.

## Judgment in Favor of Plaintiff (`plaintiff-judgment.typ`) and Defendant (`defendant-judgment.typ`)

Baselines: AG 13 "Judgment In Favor of Plaintiff" and AG 14 "Judgment In
Favor of Defendant". Office forms, on letterhead.

| Our field                                                                            | AG 13 / 14                                   |
| ------------------------------------------------------------------------------------ | -------------------------------------------- |
| Caption, Case No.                                                                    | caption; Ward, District, Parish              |
| Trial as assigned, both parties appeared                                             | same                                         |
| 13: plaintiff proved the demand                                                      | same                                         |
| 14: plaintiff failed to prove the demand; defendant proved the reconventional demand | same                                         |
| "Ordered, adjudged, and decreed": judgment for one party against the other           | same                                         |
| Sum in words and figures; interest percent from a date until paid; court costs       | same                                         |
| "Judgment read, rendered, and signed in open court" on a date                        | same                                         |
| Justice of the Peace signs                                                           | Justice of the Peace, Ward, District, Parish |

As in the samples, both assume both parties appeared; a default judgment is
its own form, below. A judgment for the defendant with no reconventional
demand is not covered. "District" is left out, as on the other captions.

## Default Judgment (`default-judgment.typ`)

Baseline: AG 12 "Default Judgment". An office form, on letterhead.

| Our field                                                                                | AG 12                                        | Law                         |
| ---------------------------------------------------------------------------------------- | -------------------------------------------- | --------------------------- |
| Caption, Case No.                                                                        | caption; Ward, District, Parish              |                             |
| Trial as assigned; defendant cited and failed to appear or answer within the legal delay | same                                         | art. 4921, default judgment |
| "Ordered, adjudged, and decreed": judgment for the plaintiff against the defendant       | same                                         |                             |
| Sum in words and figures; interest percent from a date until paid; court costs           | same                                         |                             |
| "Thus done and signed" at a place, Louisiana, on a date                                  | same                                         |                             |
| Justice of the Peace signs                                                               | Justice of the Peace, Ward, District, Parish |                             |

## Citation (`citation.typ`)

Baseline: AG 05 "Citation". An office form, on letterhead.

| Our field                                                        | AG 05                                                  | Law                                            |
| ---------------------------------------------------------------- | ------------------------------------------------------ | ---------------------------------------------- |
| Caption, Case No.; court name, address, telephone (letterhead)   | same                                                   |                                                |
| Plaintiff and defendant: address, telephone                      | address, telephone, fax                                |                                                |
| "You have been sued"; petition and supporting documents attached | same                                                   |                                                |
| Comply or answer, with exceptions, within ten days of service    | same; "use the form ... entitled 'Defendant's Answer'" | art. 4920                                      |
| Or appear for trial on a date and time at the office             |                                                        | art. 4921.1, trial 10 to 45 days after service |
| Default judgment warning; talk with an attorney                  | same                                                   | art. 4921                                      |
| "Witness my hand"; Justice of the Peace signs                    | "WITNESS THIS ... DAY OF"                              |                                                |

Departure, at the office's request: a box for a trial date. The office asked
for a citation with the court date; the law lets a citation set a trial date
in place of the ten days to answer. One of the two boxes is marked.

## Rule to Show Cause: Eviction (`eviction-rule.typ`)

Baseline: AG 44 "Petition Order", the order on the eviction petition. An
office form, on letterhead. The office asked for "the form that says you have
been sued for eviction".

| Our field                                                                          | AG 44                             | Law                                                        |
| ---------------------------------------------------------------------------------- | --------------------------------- | ---------------------------------------------------------- |
| Caption, Case No.                                                                  | none (printed under the petition) |                                                            |
| Ordered to show cause in court on a date                                           | same                              | art. 4732(A), not earlier than the third day after service |
| Time and place                                                                     |                                   |                                                            |
| Why judgment should not issue and the plaintiff not get possession within 24 hours | same                              | art. 4732                                                  |
| Default judgment warning; "let the above rule show cause"                          | same                              | art. 4732                                                  |
| "Witness my hand"; Justice of the Peace signs                                      | same                              |                                                            |

AG 44 prints the constable's section under the order. The office uses a
separate return, so it is its own form, below.

## Constable's Return: Eviction (`eviction-return.typ`)

Baseline: the constable's section of AG 44, "Constable Section: Verifying
method of delivery". An office form, on letterhead, with the caption so it
stands alone.

| Our field                                                                                                                                      | AG 44 constable section           |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| Caption, Case No.                                                                                                                              | none (under the order)            |
| Certify delivery of the petition and the rule on a date, by the method marked (the office serves them together; AG 44 says "said court order") | same                              |
| Personal: name of defendant served                                                                                                             | same                              |
| Domiciliary: name of person served                                                                                                             | same                              |
| Posted on the door, date                                                                                                                       | same                              |
| Constable signs                                                                                                                                | Constable, Ward, District, Parish |

## Constable's Return: Citation (`citation-return.typ`)

Baseline: AG 07 "Constable's Return Section". An office form, on letterhead,
at 11 point so it fits one page.

| Our field                                                                                                                              | AG 07                                                 |
| -------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| Caption, Case No.                                                                                                                      | none                                                  |
| Date the citation or other process and certified copy of the petition were received                                                    | same, repeated in each section; asked once here       |
| Personal: date, place, parish                                                                                                          | same                                                  |
| Domiciliary: date, dwelling or usual abode, parish, person of suitable age and discretion residing there, defendant temporarily absent | same                                                  |
| Certified mail, return receipt: date mailed, address, date receipt received, signed by, dated                                          | same                                                  |
| Due diligence: not served, date, reasons                                                                                               | same                                                  |
| Constable signs                                                                                                                        | Constable, Justice of the Peace Court, Ward, District |

## Court papers not published

Other judgments and the warrant for possession, with its return, are issued by
the court and are not on the site. The Attorney General baseline has them as
forms 11, 15, and 45 to 48.
