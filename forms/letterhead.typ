// Shared template for every court form. Office facts come from the same
// site.toml the website reads, so a form can never disagree with the site.

#let office = toml("/src/data/site.toml").office
#let catalog = toml("/src/data/forms.toml")

#let GOLD = rgb("#cfb070")
#let INK = rgb("#111111")
#let DISPLAY = "Cormorant SC"
#let BODY = "Source Serif 4"
#let RULE = 0.6pt
#let WRITING_LINE = 0.9cm

#let court = office.title + " Court, " + office.ward
#let venue = office.parish + " Parish, State of " + office.state

// A blank to write on. The rule sits just under the baseline so handwriting rests on it.
#let blank(width: 1fr) = box(
  width: width,
  height: 0.7em,
  stroke: (bottom: RULE),
  outset: (bottom: 2.5pt),
)

#let field(label, width: 1fr) = [#label#h(0.4em)#blank(width: width)]

#let lines(count) = block(above: 0.3em, breakable: false, for _ in range(count) {
  block(width: 100%, height: WRITING_LINE, stroke: (bottom: RULE), spacing: 0pt)
})

#let tick = box(width: 0.9em, height: 0.9em, stroke: 0.8pt, baseline: 0.12em)

// `check` flows inline, several to a line. `item` stands alone and hangs its wrapped lines.
#let check(body) = [#tick#h(0.45em)#body]

#let item(body) = grid(columns: (auto, 1fr), column-gutter: 0.45em, [#tick], body)

#let checks(..items) = block({
  set par(leading: 1.2em)
  items.pos().map(body => box(check(body))).join(h(1.6em))
})

#let signature(label) = block(breakable: false, width: 100%)[
  #v(0.6cm)
  #line(length: 100%, stroke: RULE)
  #v(-0.6em)
  #text(size: 10pt, label)
]

#let note(body) = block(
  width: 100%,
  inset: (left: 10pt, y: 6pt),
  stroke: (left: 2.5pt + GOLD),
  text(size: 10.5pt, body),
)

#let court-use(body) = block(
  breakable: false,
  width: 100%,
  inset: 10pt,
  stroke: 0.8pt,
)[
  #text(font: DISPLAY, weight: 700, size: 12pt)[For court use only]
  #body
]

// Parties on the left, court and case number on the right, as on a court caption.
#let caption(first: "Plaintiff(s)", second: "Defendant(s)") = grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  [
    #field[]
    #v(-0.5em)
    #text(size: 10pt, first)

    #align(center, text(font: DISPLAY, weight: 600)[versus])

    #field[]
    #v(-0.5em)
    #text(size: 10pt, second)
  ],
  [
    #field(strong[Case No.])

    #court \
    #venue
  ],
)

// The monogram is the initial of the name, so the wordmark starts at the second letter.
#let lockup = pdf.artifact(stack(
  dir: ttb,
  spacing: 6pt,
  text(font: DISPLAY, weight: 700, size: 28pt, bottom-edge: "baseline")[#box(
      image("/src/assets/monogram.svg", height: 32pt),
    )#h(1pt)#office.justice.slice(1)],
  text(font: DISPLAY, weight: 600, size: 13pt, tracking: 0.4pt)[#office.title · #office.ward],
))

#let letterhead = block(width: 100%, below: 1.4em)[
  #grid(
    columns: (auto, 1fr),
    align: (left + bottom, right + bottom),
    lockup,
    text(size: 9.5pt)[
      #set par(leading: 0.5em)
      #office.justice, #office.title \
      #office.ward, #venue \
      #office.address.street, #office.address.city, #office.address.state #office.address.zip \
      Telephone #office.phone · #office.email
    ],
  )
  #v(-0.4em)
  #pdf.artifact(line(length: 100%, stroke: 2pt + GOLD))
]

// `from-court: false` is for papers a party gives to another party. They must not
// look as if the court issued them, so they carry no letterhead.
#let form(id: none, from-court: true, body) = {
  let entry = catalog.at(id)
  let revised = entry.revised.display("[month repr:long] [day padding:none], [year]")
  set document(title: entry.title + ", " + court, author: court)
  set text(font: BODY, size: 12pt, lang: "en", fill: INK)
  set par(leading: 0.8em, spacing: 1.4em)
  set block(spacing: 1.4em)
  set grid(column-gutter: 1.2em, row-gutter: 1.4em)
  set page(
    paper: "us-letter",
    margin: (x: 0.9in, top: 0.8in, bottom: 1in),
    footer: context text(size: 9pt)[
      #set par(leading: 0.45em)
      #pdf.artifact(line(length: 100%, stroke: 0.4pt))
      #v(-0.5em)
      #entry.title · Revised #revised
      #h(1fr)
      Page #counter(page).display() of #counter(page).final().first() \
      #if from-court [
        #court, #venue. Court staff cannot give legal advice.
      ] else [
        Blank form from the #court, #venue. Not issued by the court.
      ]
    ],
  )
  show heading: set text(font: DISPLAY, fill: INK)
  show heading.where(level: 1): it => align(center, block(above: 0.4em, below: 1em, text(
    size: 24pt,
    weight: 700,
    it.body,
  )))
  show heading.where(level: 2): it => block(above: 1.5em, below: 0.9em, breakable: false, sticky: true)[
    #text(size: 14.5pt, weight: 700, it.body)
    #v(-0.75em)
    #pdf.artifact(line(length: 100%, stroke: 1.2pt + GOLD))
  ]
  if from-court { letterhead }
  heading(level: 1, entry.title)
  body
}
