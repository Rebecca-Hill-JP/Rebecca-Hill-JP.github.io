import { getEntry } from "astro:content";

const entry = await getEntry("site", "office");
if (!entry) {
  throw new Error(
    "src/data/site.toml has no [office] table; restore it so pages can read the office facts.",
  );
}

export const office = entry.data;
export const court = `${office.title} Court, ${office.ward}`;

/** A North American number as a dialable link, whatever punctuation the office wrote it with. */
export const telephone_link = (number: string): string =>
  `tel:+1${number.replace(/\D/g, "")}`;
export const jurisdiction = `${office.parish} Parish, ${office.state}`;
