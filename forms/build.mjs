// Compile every form listed in src/data/forms.toml to public/forms/<id>.pdf.
// PDF/UA-1 makes Typst refuse to emit an untagged or untitled document.
import { execFileSync } from "node:child_process";
import { mkdirSync, readFileSync } from "node:fs";
import { parse } from "smol-toml";

const OUTPUT = "public/forms";
const catalog = parse(readFileSync("src/data/forms.toml", "utf8"));

mkdirSync(OUTPUT, { recursive: true });
for (const id of Object.keys(catalog)) {
  execFileSync(
    "typst",
    [
      "compile",
      "--root",
      ".",
      "--font-path",
      "forms/fonts",
      "--ignore-system-fonts",
      "--pdf-standard",
      "ua-1",
      `forms/${id}.typ`,
      `${OUTPUT}/${id}.pdf`,
    ],
    { stdio: "inherit" },
  );
  console.log(`${OUTPUT}/${id}.pdf`);
}
