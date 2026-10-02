# Justice of the Peace, Ward 10

The official website of Rebecca Hill, Justice of the Peace, Ward 10. It tells
residents what the court does, what it costs, and how to file, and gives them
printable forms.

Static site: Astro, Markdown, hand-written CSS. The only client JavaScript is
the address check on the About page. Forms are PDFs built from Typst sources.

## Commands

| Command                | Does                                                              |
| ---------------------- | ----------------------------------------------------------------- |
| `npm run dev`          | Local site with live reload (run `npm run forms` once first)      |
| `npm run build`        | Build the forms, then the site, into `dist/`                      |
| `npm run check`        | Type-check and validate content against its schemas               |
| `npm run forms`        | Compile `forms/*.typ` to `public/forms/*.pdf`                     |
| `npm run placeholders` | List every unconfirmed fact; fails while any remains              |
| `npm run law`          | Confirm the statute wording the site relies on is unchanged       |
| `npm run map`          | Redraw the ward map and address list from parish GIS (needs `uv`) |
| `npm test`             | Test the address search                                           |

Needs Node 24 and Typst 0.14.

## Where each fact lives

Each fact is stated once.

| Fact                                         | File                        |
| -------------------------------------------- | --------------------------- |
| Office name, address, hours, people          | `src/data/site.toml`        |
| Form titles, purposes, revision dates        | `src/data/forms.toml`       |
| Service steps, fees, what to bring, statutes | `src/content/services/*.md` |
| Statute wording the pages rest on            | `law/claims.toml`           |
| Form fields and where each came from         | `forms/SOURCES.md`          |

The website and the PDF letterhead both read `site.toml`, so they cannot
disagree.

## Placeholders

A fact the office has not confirmed is the literal word `TODO`. The deploy
workflow runs `npm run placeholders` first and refuses to publish while any
remains. None remains: the office answered the intake questionnaire on
2026-10-02.

Where the office left a question blank, the site says nothing or says "Ask the
office"; it does not guess. Still open:

- a biography for the About page;
- fees for an answer, a subpoena, a constable move-out, and notary work;
- regular hearing days, if any;
- whether the court has a district or division name. Ward 10 has two justices
  of the peace, and the site calls this one "Justice of the Peace Court,
  Ward 10";
- the forms the office uses today, to compare with the drafts.

Looked up, not supplied by the office, and to be confirmed by her: the clerk
of court's address for appeals (from the clerk's information guide) and the
description of Ward 10 (from the parish map).

## Ward map

`src/assets/ward-10.svg` is drawn by `map/build.py` from St. Tammany Parish
Government GIS layers: ward boundaries, town limits, major roads, street names,
and the office's address point. Nothing on it is traced by hand, and no label
is placed by hand: each state route that enters the ward is named where it is
farthest from other roads and labels, with the local name of that stretch
beneath the route number. Run `npm run map` if the parish changes the boundary.

## Address check

The box under the map tells a resident whether an address is in Ward 10. It
calls no geocoding service. `map/addresses.py` takes the parish's own address
points, tests each against the ward boundary, and writes
`src/assets/ward-10-addresses.json`; the page searches that list in the
browser, so nothing a resident types leaves their device and no outside
service can change under the site.

- The list holds every address in the ward and within a mile of it, so an
  address just outside gets "not in Ward 10" instead of "not found".
- An address within 50 feet of the boundary is not called either way; the page
  says to call the office. The parish's line strays up to 20 feet from the
  road it follows, and its address points are not surveyed.
- An answer is given only for an address on the list. Street names are matched
  loosely (abbreviations, a misspelling, one wrong word) and a loose match is
  labeled as such; a house number or route number is never guessed.
- The build stops if the office's own address does not come out inside the
  ward.

The list ages as houses are built. Run `npm run map` every few months and
commit the result; the page shows the date of the records.

The layers are copyright St. Tammany Parish Government and St. Tammany Parish
Communications District No. 1, published "for informational purposes only" and
"not to be sold for profit". They carry no open license. The map credits both
and says it is not a survey; written permission from the parish GIS division
has not been obtained.

## Law

Every legal statement was written from the statute text on legis.la.gov and
cites it. Nothing came from memory or from another court's site. Two facts
differ from what is commonly repeated, so do not "correct" them:

- The wait between a marriage license and the ceremony is 24 hours, not 72
  (R.S. 9:241, amended 2018).
- The cost amounts in R.S. 13:2590 are ceilings ("may demand and receive up
  to"), so each fee on the site is the office's own figure, with the ceiling
  noted beside it.

`npm run law` fetches each cited section and checks that the wording in
`law/claims.toml` is still there. It runs monthly in GitHub Actions. When it
fails, read the amended text, correct the page, then update the claim.

An independent review on 2026-10-02 checked every legal statement on the site
and forms against the statute text (`law/review-2026-10-02.md`, which describes
the site as it was before the corrections). It found none wrong and 13 to
tighten or drop; all 13 were acted on. The rule applied: where a statement is
uncertain, leave it out. A resident can ask the office; a wrong statement on a
court's site does harm.

Two corrections matter most. Saturdays and Sundays do not count in the five-day
notice to vacate (R.S. 1:55(E)(3)). And the forms no longer ask for anything
the law does not require: witnesses to a notice, a mailed copy of an answer, a
consent to judgment.

A second review the same day covered the two marriage waivers and the vehicle
judgment (`law/review-forms-2026-10-02.md`). The waivers needed only wording
changes. The vehicle form was rebuilt: the Attorney General's sample has the
justice render judgment on the applicant's affidavit alone, and the review
found that the Code requires a suit, with a defendant who is served
(C.C.P. arts. 1201, 4912, 4913). The form now names the owner of record as
defendant and the judgment recites service and the hearing. This is a choice
about how the court handles these cases, so it is hers to confirm.

The Justice of the Peace reviews all legal wording and every form before launch.

## Forms

Louisiana does not require written pleadings in a justice of the peace court
(C.C.P. art. 4917), so the forms are the court's own design. `forms/SOURCES.md`
maps every field to the baseline forms and the statute behind it.

`forms/letterhead.typ` is the shared template. The Notice to Vacate carries no
court letterhead on purpose: the landlord gives it, the court does not, and it
must not look like a court paper.

PDFs are built as PDF/UA-1, so Typst refuses to emit an untagged document.

## Design

- Gold `#cfb070` (sampled from the office sign), ink `#111111`, paper `#faf7f0`.
  Gold type appears only on ink; on paper it fails contrast, so there it is
  used for rules and fills only.
- Cormorant SC for the wordmark and headings; it matches the sign. Source
  Serif 4 for text. Both are served from this site; no third-party requests.
- The wordmark is live text. Only the monogram (the initial with the figure of
  Justice) is an image, traced once to `src/assets/monogram.svg`.
- The sign itself is campaign material and stays out of the repository
  (`reference/`). The site carries no election wording.

## Publishing

Not yet published. `.github/workflows/deploy.yml` deploys to GitHub Pages on a
push to `main` once the repository has a remote, Pages is enabled, and no
placeholder remains.
