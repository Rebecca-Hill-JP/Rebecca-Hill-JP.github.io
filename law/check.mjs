// Fetch every statute in claims.toml from legis.la.gov and confirm the wording
// the site relies on is still there. Also confirm every statute the site links
// to is covered by a claim.
import { readFileSync, readdirSync } from "node:fs";
import { parse } from "smol-toml";

const SOURCE = "https://legis.la.gov/Legis/LawPrint.aspx?d=";
const SERVICES = "src/content/services";
const ENTITIES = {
  "&nbsp;": " ",
  "&#160;": " ",
  "&amp;": "&",
  "&quot;": '"',
  "&#39;": "'",
};

const plain = (html) =>
  html
    .replace(/<(script|style)[\s\S]*?<\/\1>/g, " ")
    .replace(/<[^>]*>/g, " ")
    .replace(/&[#\w]+;/g, (entity) => ENTITIES[entity] ?? entity)
    .replace(/[‘’]/g, "'")
    .replace(/\s+/g, " ");

const claims = parse(readFileSync("law/claims.toml", "utf8"));
const failures = [];

const linked = readdirSync(SERVICES)
  .flatMap(
    (file) =>
      readFileSync(`${SERVICES}/${file}`, "utf8").match(/Law\.aspx\?d=\d+/g) ??
      [],
  )
  .map((link) => link.split("=")[1]);
for (const id of new Set(linked)) {
  if (!(id in claims))
    failures.push(`d=${id}: linked from a service page but has no claim`);
}

for (const [id, { cite, phrases }] of Object.entries(claims)) {
  const response = await fetch(SOURCE + id);
  if (!response.ok) {
    failures.push(`${cite}: HTTP ${response.status} from ${SOURCE}${id}`);
    continue;
  }
  const text = plain(await response.text());
  const missing = phrases.filter((phrase) => !text.includes(phrase));
  for (const phrase of missing)
    failures.push(`${cite}: no longer says "${phrase}"`);
  console.log(`${missing.length ? "FAIL" : "ok  "} ${cite}`);
}

if (failures.length) {
  console.error(
    `\n${failures.join("\n")}\n\nRead the current text, then correct the site and law/claims.toml.`,
  );
  process.exit(1);
}
