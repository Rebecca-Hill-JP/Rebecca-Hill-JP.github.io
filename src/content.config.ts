import { defineCollection, reference } from "astro:content";
import { file, glob } from "astro/loaders";
import { z } from "astro/zod";

const text = z.string().min(1);

const site = defineCollection({
  loader: file("src/data/site.toml"),
  schema: z.strictObject({
    justice: text,
    title: text,
    ward: text,
    parish: text,
    state: text,
    year_elected: text,
    phone: text,
    email: text,
    hours: z.array(text).min(1),
    territory: text,
    constable: text,
    constable_phone: text,
    payment_methods: text,
    payable_to: text,
    how_to_file: text,
    address: z.strictObject({
      street: text,
      city: text,
      state: text,
      zip: text,
    }),
  }),
});

const forms = defineCollection({
  loader: file("src/data/forms.toml"),
  schema: z.strictObject({
    title: text,
    purpose: text,
    revised: z.coerce.date(),
  }),
});

const services = defineCollection({
  loader: glob({ pattern: "*.md", base: "src/content/services" }),
  schema: z.strictObject({
    title: text,
    summary: text,
    order: z.number().int(),
    fees: z.array(
      z.strictObject({ item: text, amount: text, note: text.optional() }),
    ),
    bring: z.array(text),
    forms: z.array(reference("forms")),
    statutes: z.array(z.strictObject({ cite: text, url: z.url() })).min(1),
  }),
});

export const collections = { site, forms, services };
