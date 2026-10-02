import { getEntry } from "astro:content";

const entry = await getEntry("site", "office");
if (!entry) {
  throw new Error(
    "src/data/site.toml has no [office] table; restore it so pages can read the office facts.",
  );
}

export const office = entry.data;
export const court = `${office.title} Court, ${office.ward}`;
export const jurisdiction = `${office.parish} Parish, ${office.state}`;
