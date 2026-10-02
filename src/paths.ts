const BASE = import.meta.env.BASE_URL.replace(/\/$/, "");

/** Prefix a root-relative path with the deploy base, so the site works under a project subpath. */
export const href = (path: string): string => `${BASE}${path}`;
