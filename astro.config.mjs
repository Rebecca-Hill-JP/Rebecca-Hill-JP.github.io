import { defineConfig, fontProviders } from "astro/config";

const FALLBACKS = ["Georgia", "Times New Roman", "serif"];

// SITE_URL and BASE_PATH come from the Pages deploy workflow; local builds serve from "/".
export default defineConfig({
  site: process.env.SITE_URL,
  base: process.env.BASE_PATH ?? "/",
  trailingSlash: "always",
  build: { inlineStylesheets: "always" },
  // Font files come from the Fontsource packages and are served from this site.
  // Astro derives metric-matched fallbacks, so text does not jump when they load.
  fonts: [
    {
      provider: fontProviders.local(),
      name: "Cormorant SC",
      cssVariable: "--display",
      fallbacks: FALLBACKS,
      options: {
        variants: [
          {
            src: [
              "@fontsource/cormorant-sc/files/cormorant-sc-latin-600-normal.woff2",
            ],
            weight: 600,
            style: "normal",
          },
          {
            src: [
              "@fontsource/cormorant-sc/files/cormorant-sc-latin-700-normal.woff2",
            ],
            weight: 700,
            style: "normal",
          },
        ],
      },
    },
    {
      provider: fontProviders.local(),
      name: "Source Serif 4",
      cssVariable: "--body",
      fallbacks: FALLBACKS,
      options: {
        variants: [
          {
            src: [
              "@fontsource-variable/source-serif-4/files/source-serif-4-latin-wght-normal.woff2",
            ],
            weight: "200 900",
            style: "normal",
          },
        ],
      },
    },
  ],
});
