/* Search of src/assets/ward-10-addresses.json, the parish's own address list.
   An answer is only ever given for an address on that list. What the resident
   types is matched to it by spelling; the house number is never guessed. */

export type Side = "inside" | "outside" | "edge";

export interface Street {
  name: string;
  city: string;
  inside: number[];
  outside: number[];
  edge: number[];
}

export interface Entry {
  street: Street;
  /** The street name and then its city, as the words a search is matched against. */
  words: string[];
}

export interface Address {
  street: Street;
  number: number;
  side: Side;
}

export interface Found {
  /** The house number as typed, if one was. */
  number?: string;
  /** True when no street is spelled as typed and `streets` holds the nearest spellings. */
  close: boolean;
  /** Listed addresses on `streets` that begin with the number typed, an exact number first. */
  addresses: Address[];
  /** The streets that fit the street name typed; none if no name was typed. */
  streets: Street[];
}

const SIDES: Side[] = ["inside", "outside", "edge"];

/* The parish's spelling of each word a resident may write another way. Both the
   list and the search pass through it, so the two always agree. */
const PARISH_SPELLING: Record<string, string> = {
  AVE: "AV",
  AVENUE: "AV",
  BOULEVARD: "BLVD",
  CIRCLE: "CIR",
  COURT: "CT",
  CROSSING: "CRSG",
  DRIVE: "DR",
  EAST: "E",
  EXTENSION: "EXT",
  HIGHWAY: "HWY",
  LA: "HWY",
  LANE: "LN",
  NORTH: "N",
  PARK: "PK",
  PARKWAY: "PKWY",
  PLACE: "PL",
  ROAD: "RD",
  SAINT: "ST",
  SOUTH: "S",
  STREET: "ST",
  TER: "TRC",
  TERRACE: "TRC",
  TRAIL: "TR",
  TRL: "TR",
  US: "HWY",
  WEST: "W",
  XING: "CRSG",
};

const UNIT = /\b(?:SUITE|STE|APT|UNIT|LOT)\b\s*\S*|#\s*\S+/g;
const STATE = ["LA", "LOUISIANA"];
const ZIP = /^\d{5}$/;
const HOUSE_NUMBER = /^(\d+)[A-Z]?$/;
/* A word of at least this many letters may be misspelled by one letter, or by two from twice as many. */
const TYPO_LENGTH = 4;

function split(text: string): string[] {
  return text
    .toUpperCase()
    .replace(/['’.]/g, "")
    .replace(UNIT, " ")
    .split(/[^A-Z0-9]+/)
    .filter(Boolean);
}

function parish(word: string): string {
  return PARISH_SPELLING[word] ?? word;
}

export function index(streets: Street[]): Entry[] {
  return streets.map((street) => ({
    street,
    words: split(`${street.name} ${street.city}`).map(parish),
  }));
}

/* Each word typed, as the spellings it may stand for. The last word may be
   unfinished, so "aven" also stands for the parish's "AV". */
function spellings(words: string[]): string[][] {
  return words.map((word, at) => {
    const unfinished =
      at === words.length - 1
        ? Object.keys(PARISH_SPELLING)
            .filter((long) => long.startsWith(word))
            .map(parish)
        : [];
    return [parish(word), ...unfinished];
  });
}

function distance(a: string, b: string): number {
  let row = Array.from({ length: b.length + 1 }, (_, column) => column);
  for (let i = 1; i <= a.length; i++) {
    const next = [i];
    for (let j = 1; j <= b.length; j++) {
      const swap = row[j - 1] + (a[i - 1] === b[j - 1] ? 0 : 1);
      next.push(Math.min(swap, row[j] + 1, next[j - 1] + 1));
    }
    row = next;
  }
  return row[b.length];
}

/* Whether `typed` misspells `word` by few enough letters. A finished word is
   held against the whole of `word`, so Rose does not find Robert; an unfinished
   one against its start. A number is never a misspelling: Hwy 1082 and Hwy 1083
   are different roads. */
function misspells(typed: string, word: string, unfinished: boolean): boolean {
  if (/\d/.test(typed)) return false;
  const allowed = Math.min(2, Math.floor(typed.length / TYPO_LENGTH));
  const ends = unfinished
    ? [typed.length - 1, typed.length, typed.length + 1]
    : [word.length];
  return ends.some((end) => distance(typed, word.slice(0, end)) <= allowed);
}

type Fit = (typed: string, word: string, unfinished: boolean) => boolean;

const begins: Fit = (typed, word) => word.startsWith(typed);
const nearly: Fit = (typed, word, unfinished) =>
  begins(typed, word, unfinished) || misspells(typed, word, unfinished);

/* Whether every word typed fits a word of the street, in the order typed. */
function follows(typed: string[][], words: string[], fit: Fit): boolean {
  let at = 0;
  for (const word of words) {
    const unfinished = at === typed.length - 1;
    if (typed[at]?.some((form) => fit(form, word, unfinished))) at++;
  }
  return at === typed.length;
}

/* The ways a street can fit what was typed, the surest first: as typed; with a
   word misspelled; with one wrong word ("Rose Dr" for Rose St) beside a word
   long enough to identify the street; with both faults. */
function fits(typed: string[][]): ((words: string[]) => boolean)[] {
  const short = typed
    .map((_, dropped) => typed.filter((_, at) => at !== dropped))
    .filter((rest) => rest.some(([word]) => word.length >= TYPO_LENGTH));
  return [
    (words) => follows(typed, words, begins),
    (words) => follows(typed, words, nearly),
    (words) => short.some((rest) => follows(rest, words, begins)),
    (words) => short.some((rest) => follows(rest, words, nearly)),
  ];
}

function addresses(streets: Street[], number: string): Address[] {
  return streets
    .flatMap((street) =>
      SIDES.flatMap((side) =>
        street[side]
          .filter((listed) => String(listed).startsWith(number))
          .map((listed) => ({ street, number: listed, side })),
      ),
    )
    .sort(
      (a, b) =>
        Number(String(b.number) === number) -
          Number(String(a.number) === number) || a.number - b.number,
    );
}

export function search(entries: Entry[], text: string): Found {
  const words = split(text);
  const number = words[0]?.match(HOUSE_NUMBER)?.[1];
  if (number) words.shift();
  /* A pasted address ends in a state and ZIP code the list does not carry. */
  if (words.length > 1 && ZIP.test(words[words.length - 1])) words.pop();
  if (words.length > 1 && STATE.includes(words[words.length - 1])) words.pop();
  let streets: Street[] = [];
  let close = false;
  for (const [tier, fit] of fits(spellings(words)).entries()) {
    streets = entries
      .filter((entry) => fit(entry.words))
      .map((entry) => entry.street);
    close = tier > 0 && streets.length > 0;
    if (streets.length) break;
  }
  return {
    number,
    close,
    addresses: number ? addresses(streets, number) : [],
    streets: words.length ? streets : [],
  };
}

/* Where a whole street lies, by the addresses listed on it. */
export function whole(street: Street): "inside" | "outside" | "mixed" {
  if (!street.outside.length && !street.edge.length) return "inside";
  if (!street.inside.length && !street.edge.length) return "outside";
  return "mixed";
}
