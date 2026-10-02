# Justice of the Peace, Ward 10

The official website of Rebecca Hill, Justice of the Peace, Ward 10. It tells
residents what the court does, what it costs, and how to file, and gives them
printable forms.

Static site: Astro, Markdown, hand-written CSS, no client JavaScript. Forms are
PDFs built from Typst sources.

## Commands

| Command                | Does                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `npm run dev`          | Local site with live reload (run `npm run forms` once first) |
| `npm run build`        | Build the forms, then the site, into `dist/`                 |
| `npm run check`        | Type-check and validate content against its schemas          |
| `npm run forms`        | Compile `forms/*.typ` to `public/forms/*.pdf`                |
| `npm run placeholders` | List every unconfirmed fact; fails while any remains         |
| `npm run law`          | Confirm the statute wording the site relies on is unchanged  |

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
remains. Replace each one from the office's answers to
`intake/office-questionnaire.docx` (not in the repository).

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
