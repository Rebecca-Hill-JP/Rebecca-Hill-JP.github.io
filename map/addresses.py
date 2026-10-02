"""Write src/assets/ward-10-addresses.json: each parish address in or near the ward, and its side of the boundary.

The site searches this list in the browser, so a resident's address is sent
nowhere and no geocoding service can go stale. Positions are the parish's own
address points; nothing is geocoded.
"""

import json
import string
from collections import defaultdict
from datetime import date
from pathlib import Path

import shapely

from .gis import OFFICE_ADDRESS, WARD, query, query_all

TARGET = Path("src/assets/ward-10-addresses.json")
STATE_PLANE = "3452"  # the layers' own coordinate system (Louisiana South), in feet
# Feet beyond the ward that are listed, so an address just outside it gets an answer instead of "not found".
NEARBY = 5280
# Feet from the boundary within which an address is not called either way. Where the
# boundary follows Harrison Avenue, the parish's line strays up to 20 feet from the
# centerline and the nearest house stands 74 feet from it; 50 covers the first and spares the second.
MARGIN = 50

type Sides = dict[tuple[str, str], dict[int, set[str]]]


def split(address: str, streets: frozenset[str]) -> tuple[int, str]:
    """House number and street of a parish address.

    Drops a unit letter ("19306B FITZGERALD LN") and whatever follows the longest
    known street name ("78005 HWY 1083 BARN"), so a house and its shed are one address.
    """
    number, rest = address.strip().split(" ", 1)
    tokens = rest.split()
    names = (" ".join(tokens[:count]) for count in range(len(tokens), 0, -1))
    street = next(name for name in names if name in streets)
    return int(number.rstrip(string.ascii_uppercase)), street


def side(ward: shapely.Polygon, point: shapely.Point) -> str:
    if ward.boundary.distance(point) < MARGIN:
        return "edge"
    return "inside" if ward.contains(point) else "outside"


def title(name: str) -> str:
    return " ".join(word.capitalize() for word in name.split())


def sides(ward: shapely.Polygon, points: list[dict], streets: frozenset[str]) -> Sides:
    """The side of every point at each house number, by street and postal city."""
    found: Sides = defaultdict(lambda: defaultdict(set))
    for feature in points:
        point = shapely.geometry.shape(feature["geometry"])
        if ward.distance(point) <= NEARBY:
            number, street = split(feature["properties"]["ADDRESS"], streets)
            city = feature["properties"]["CITY_L"]
            found[(street, city)][number].add(side(ward, point))
    return found


def records(found: Sides) -> list[dict]:
    """One record per street; a number whose points disagree (a house and its barn) is on the edge."""
    resolved = {
        key: {
            number: next(iter(seen)) if len(seen) == 1 else "edge"
            for number, seen in numbers.items()
        }
        for key, numbers in found.items()
    }
    return [
        {
            "name": title(street),
            "city": title(city),
            **{
                kind: sorted(number for number, own in numbers.items() if own == kind)
                for kind in ("inside", "outside", "edge")
            },
        }
        for (street, city), numbers in sorted(resolved.items())
    ]


def build() -> dict:
    wards = query("Police_Jury_Wards", outSR=STATE_PLANE)
    outline = next(ward for ward in wards if ward["properties"]["WARD_txt"] == WARD)
    ward = shapely.geometry.shape(outline["geometry"])
    west, south, east, north = ward.buffer(NEARBY).bounds
    envelope = {
        "geometry": f"{west},{south},{east},{north}",
        "geometryType": "esriGeometryEnvelope",
        "inSR": STATE_PLANE,
        "spatialRel": "esriSpatialRelIntersects",
    }
    roads = query_all(
        "Roads", outFields="OBJECTID,STREET,ALIAS", returnGeometry="false", **envelope
    )
    streets = frozenset(
        name.strip()
        for road in roads
        for name in (road["properties"]["STREET"], road["properties"]["ALIAS"])
        if name and name.strip()
    )
    points = query_all(
        "Address_Points",
        outFields="OBJECTID,ADDRESS,CITY_L",
        outSR=STATE_PLANE,
        **envelope,
    )
    found = sides(ward, points, streets)
    number, street = split(OFFICE_ADDRESS, streets)
    office = [
        numbers[number]
        for (name, _), numbers in found.items()
        if name == street and number in numbers
    ]
    if office != [{"inside"}]:
        raise ValueError(
            f"The office, {OFFICE_ADDRESS}, should be inside Ward {WARD} but resolves to {office}. "
            "The parish layers or the address parsing changed; find out which before publishing this list."
        )
    return {"updated": date.today().isoformat(), "streets": records(found)}


def write() -> None:
    TARGET.write_text(json.dumps(build(), separators=(",", ":")) + "\n")
    print(TARGET, TARGET.stat().st_size, "bytes")
