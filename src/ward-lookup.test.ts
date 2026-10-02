import assert from "node:assert/strict";
import { test } from "node:test";
import { index, search, whole, type Street } from "./ward-lookup.ts";

const LEVESON: Street = {
  name: "Leveson St",
  city: "Abita Springs",
  inside: [71667, 71675],
  outside: [],
  edge: [],
};
const ROSE: Street = {
  name: "Rose St",
  city: "Covington",
  inside: [72322],
  outside: [72483],
  edge: [72333],
};
const HARRISON_ABITA: Street = {
  name: "Harrison Av",
  city: "Abita Springs",
  inside: [21499],
  outside: [21500],
  edge: [],
};
const HARRISON_COVINGTON: Street = {
  name: "Harrison Av",
  city: "Covington",
  inside: [],
  outside: [20291],
  edge: [],
};
const HIGHWAY_1082: Street = {
  name: "Hwy 1082",
  city: "Covington",
  inside: [78017],
  outside: [],
  edge: [],
};
const HIGHWAY_1083: Street = {
  name: "Hwy 1083",
  city: "Bush",
  inside: [7801],
  outside: [78005],
  edge: [],
};
const ROBERT: Street = {
  name: "Robert Ct",
  city: "Abita Springs",
  inside: [72322],
  outside: [],
  edge: [],
};
const ENTRIES = index([
  LEVESON,
  ROSE,
  ROBERT,
  HARRISON_ABITA,
  HARRISON_COVINGTON,
  HIGHWAY_1082,
  HIGHWAY_1083,
]);

test("an address as the office writes it, with suite, state and ZIP", () => {
  assert.deepEqual(
    search(ENTRIES, "71667 Leveson Street, Suite 6, Abita Springs, LA 70420"),
    {
      number: "71667",
      close: false,
      addresses: [{ street: LEVESON, number: 71667, side: "inside" }],
      streets: [LEVESON],
    },
  );
});

test("an unfinished word still finds the parish's abbreviation", () => {
  assert.deepEqual(search(ENTRIES, "21499 harrison aven").addresses, [
    { street: HARRISON_ABITA, number: 21499, side: "inside" },
  ]);
});

test("a state route written LA finds the parish's HWY", () => {
  assert.deepEqual(search(ENTRIES, "78017 LA 1082").addresses, [
    { street: HIGHWAY_1082, number: 78017, side: "inside" },
  ]);
});

test("the exact house number comes before longer numbers that begin with it", () => {
  assert.deepEqual(search(ENTRIES, "7801 hwy").addresses, [
    { street: HIGHWAY_1083, number: 7801, side: "inside" },
    { street: HIGHWAY_1082, number: 78017, side: "inside" },
  ]);
});

test("a city after the street tells two streets of one name apart", () => {
  assert.deepEqual(search(ENTRIES, "harrison av covington").streets, [
    HARRISON_COVINGTON,
  ]);
});

test("a misspelled street is offered as a near match, never as exact", () => {
  assert.deepEqual(search(ENTRIES, "71667 Levison St"), {
    number: "71667",
    close: true,
    addresses: [{ street: LEVESON, number: 71667, side: "inside" }],
    streets: [LEVESON],
  });
});

test("one wrong word beside the street's name is a near match", () => {
  assert.deepEqual(search(ENTRIES, "72322 Rose Dr"), {
    number: "72322",
    close: true,
    addresses: [{ street: ROSE, number: 72322, side: "inside" }],
    streets: [ROSE],
  });
});

test("a house number is never matched approximately", () => {
  assert.deepEqual(search(ENTRIES, "71668 Leveson St"), {
    number: "71668",
    close: false,
    addresses: [],
    streets: [LEVESON],
  });
});

test("a route number is never matched approximately", () => {
  assert.deepEqual(search(ENTRIES, "hwy 1084"), {
    number: undefined,
    close: false,
    addresses: [],
    streets: [],
  });
});

test("a street lies wholly in the ward only if every listed address does", () => {
  assert.equal(whole(LEVESON), "inside");
  assert.equal(whole(HARRISON_COVINGTON), "outside");
  assert.equal(whole(ROSE), "mixed");
});
