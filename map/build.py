"""Draw src/assets/ward-10.svg from St. Tammany Parish Government GIS layers.

Run `npm run map` after the parish changes a ward boundary. Every shape comes
from the parish's own data, so the map cannot drift from the official boundary.
"""

import math
import re
from pathlib import Path

import httpx

GIS = "https://maps.stpgov.org/server/rest/services/Referenced_Layers"
TARGET = Path("src/assets/ward-10.svg")
WARD = "10"
OFFICE_ADDRESS = "71667 LEVESON ST"
WIDTH = 600
MARGIN = 0.012  # degrees of context shown around the ward
BLEED = 40  # pixels kept beyond the canvas edge, so strokes run off it cleanly
MILE = 1609.344
METERS_PER_DEGREE = 111_320
SCALE_BAR_MILES = 2
LABEL_WIDTH = (
    150  # pixels allowed for the longest road label, so none runs off the canvas
)
LABEL_HEIGHT = (
    45  # pixels from the top of the route number to the foot of the local name
)
LABEL_EDGE = 20  # pixels kept clear between a road label and the canvas edge
TOWN_LABEL = (
    -90.0290,
    30.4690,
)  # (longitude, latitude), chosen by eye inside the town limits

LABEL_CLEARANCE = 40  # pixels kept between one road label and the next
# Local streets residents use to find the edge of the ward: the parish's name for each, and its label.
LANDMARK_STREETS = {"HARRISON AV": "Harrison Ave"}
TOWN_LABEL_WIDTH = 190  # pixels; the town name is centered on its point
OFFICE_LABEL_WIDTH = 120  # pixels; the office name starts beside its marker

type Point = tuple[float, float]


def query(layer: str, **params: str) -> list[dict]:
    """Return the GeoJSON features of one parish layer, in longitude and latitude."""
    defaults = {"where": "1=1", "outFields": "*", "outSR": "4326", "f": "geojson"}
    response = httpx.get(
        f"{GIS}/{layer}/MapServer/0/query", params=defaults | params, timeout=60
    )
    response.raise_for_status()
    return response.json()["features"]


def rings(geometry: dict) -> list[list[Point]]:
    """Flatten any polygon or line geometry to a list of coordinate runs."""
    depth = {"LineString": 0, "Polygon": 1, "MultiLineString": 1, "MultiPolygon": 2}[
        geometry["type"]
    ]
    runs = [geometry["coordinates"]]
    for _ in range(depth):
        runs = [inner for outer in runs for inner in outer]
    return runs


class Frame:
    """Equirectangular projection of a small area onto the SVG canvas."""

    def __init__(self, west: float, south: float, east: float, north: float) -> None:
        self.west = west
        self.north = north
        self.shrink = math.cos(math.radians((south + north) / 2))
        self.scale = WIDTH / ((east - west) * self.shrink)
        self.height = round((north - south) * self.scale)
        self.meter = self.scale / METERS_PER_DEGREE

    def project(self, point: Point) -> Point:
        longitude, latitude = point[0], point[1]
        return (
            (longitude - self.west) * self.shrink * self.scale,
            (self.north - latitude) * self.scale,
        )

    def near(self, pixel: Point) -> bool:
        x, y = pixel
        return -BLEED <= x <= WIDTH + BLEED and -BLEED <= y <= self.height + BLEED

    def area(self, geometry: dict) -> str:
        """Closed path for a shape that lies inside the canvas."""
        parts = []
        for run in rings(geometry):
            pixels = [f"{x:.1f} {y:.1f}" for x, y in map(self.project, run)]
            parts.append("M" + "L".join(pixels) + "Z")
        return "".join(parts)

    def lines(self, geometry: dict) -> str:
        """Open path of the stretches near the canvas; a parish-wide layer is mostly far away."""
        parts = []
        for run in rings(geometry):
            pixels = [self.project(point) for point in run]
            near = [self.near(pixel) for pixel in pixels]
            command = "M"
            for index, (x, y) in enumerate(pixels):
                if any(near[max(index - 1, 0) : index + 2]):
                    parts.append(f"{command}{x:.1f} {y:.1f}")
                    command = "L"
                else:
                    command = "M"
        return "".join(parts)


def along(run: list[Point], step: float) -> list[Point]:
    """Points every `step` pixels along a line, so a long straight edge can be kept clear of."""
    points = []
    for (x0, y0), (x1, y1) in zip(run, run[1:]):
        count = max(1, round(math.dist((x0, y0), (x1, y1)) / step))
        points.extend(
            (x0 + (x1 - x0) * i / count, y0 + (y1 - y0) * i / count)
            for i in range(count)
        )
    return points


def landmark_names(frame: Frame, landmarks: list[dict]) -> str:
    """Name each landmark street once, under its westernmost stretch on the canvas."""
    labels = []
    for street, label in LANDMARK_STREETS.items():
        pixels = [
            frame.project(point)
            for landmark in landmarks
            if landmark["properties"]["STREET"] == street
            for run in rings(landmark["geometry"])
            for point in run
        ]
        x, y = min(pixel for pixel in pixels if pixel[0] >= LABEL_EDGE / 2)
        labels.append(
            f'<text class="road-local" x="{x:.0f}" y="{y + 20:.0f}">{label}</text>'
        )
    return "".join(labels)


def keep_clear(start: float, end: float, y: float) -> list[Point]:
    """Points a road label must stay away from so it cannot run into a label from `start` to `end`.

    A road label extends to the right of its anchor, so the zone reaches one label width to the left.
    """
    return along([(start - LABEL_WIDTH, y), (end, y)], LABEL_CLEARANCE / 2)


def route_number(name: str) -> str | None:
    """The state route number in a name such as "LA 59" or "HWY 59"."""
    match = re.fullmatch(r"(?:LA|HWY) (\d+)", name.strip())
    return match.group(1) if match else None


def local_names(frame: Frame, streets: list[dict]) -> list[tuple[str, str, Point]]:
    """Each state route's local name, at every vertex where the parish records one.

    A state route carries its number in one field and its local name in the other,
    in either order, and the local name changes along the route (LA 59 is Level
    Street in town and Range Line Road outside it).
    """
    named = []
    for street in streets:
        fields = (
            street["properties"]["STREET"] or "",
            street["properties"]["ALIAS"] or "",
        )
        numbers = [route_number(field) for field in fields]
        names = [
            field.strip()
            for field, number in zip(fields, numbers)
            if field.strip() and not number
        ]
        if any(numbers) and names:
            number = next(number for number in numbers if number)
            named.extend(
                (number, names[0].title(), frame.project(point))
                for run in rings(street["geometry"])
                for point in run
            )
    return named


def road_names(
    frame: Frame,
    roads: list[dict],
    streets: list[dict],
    avoid: list[Point],
    ward_box: tuple[float, float, float, float],
) -> str:
    """Name each route that enters the ward, at the vertex inside it farthest from other roads and labels.

    The route number comes first and the local name of that stretch sits beneath it,
    smaller, so the map stays readable at phone width. Both lines sit above the
    vertex, clear of the road they name.
    """
    left, top_edge, right, bottom = ward_box
    vertices: dict[str, list[Point]] = {}
    for road in roads:
        pixels = [
            frame.project(point) for run in rings(road["geometry"]) for point in run
        ]
        vertices.setdefault(road["properties"]["NAME"], []).extend(
            (x, y)
            for x, y in pixels
            if left <= x <= min(right, WIDTH - LABEL_WIDTH - LABEL_EDGE)
            and top_edge + LABEL_HEIGHT <= y <= bottom
        )
    named = local_names(frame, streets)
    placed = list(avoid)
    labels = []
    for name, own in vertices.items():
        others = placed + [
            pixel
            for other, pixels in vertices.items()
            if other != name
            for pixel in pixels
        ]
        if own:
            x, y = max(
                own, key=lambda pixel: min(math.dist(pixel, other) for other in others)
            )
            number = route_number(name)
            nearby = [
                (math.dist((x, y), pixel), local)
                for route, local, pixel in named
                if route == number
            ]
            local = min(nearby)[1] if nearby else ""
            line = (
                f'<tspan class="road-local" x="{x + 8:.0f}" dy="1.15em">{local}</tspan>'
                if local
                else ""
            )
            top = y - 26 if local else y - 7
            labels.append(
                f'<text class="road-name" x="{x + 8:.0f}" y="{top:.0f}">{name}{line}</text>'
            )
            placed.extend(
                (x + offset, top + drop)
                for offset in range(8, LABEL_WIDTH, LABEL_CLEARANCE)
                for drop in (0, 19)
            )
    return "".join(labels)


def build() -> str:
    wards = query("Police_Jury_Wards")
    ward = next(
        feature for feature in wards if feature["properties"]["WARD_txt"] == WARD
    )
    outline = [point for run in rings(ward["geometry"]) for point in run]
    west = min(point[0] for point in outline) - MARGIN
    east = max(point[0] for point in outline) + MARGIN
    south = min(point[1] for point in outline) - MARGIN
    north = max(point[1] for point in outline) + MARGIN
    frame = Frame(west, south, east, north)
    envelope = {
        "geometry": f"{west},{south},{east},{north}",
        "geometryType": "esriGeometryEnvelope",
        "inSR": "4326",
        "spatialRel": "esriSpatialRelIntersects",
    }
    towns = query("City_Limit", **envelope)
    roads = query("Major_Roads", **envelope)
    streets = query("Roads", where="STN_CLASS = 'SH'", **envelope)
    street_list = ", ".join(f"'{street}'" for street in LANDMARK_STREETS)
    landmarks = query("Roads", where=f"STREET IN ({street_list})", **envelope)
    office = query("Address_Points", where=f"ADDRESS = '{OFFICE_ADDRESS}'")[0]
    office_x, office_y = frame.project(office["geometry"]["coordinates"])
    bar = SCALE_BAR_MILES * MILE * frame.meter
    bar_y = frame.height - 18
    neighbors = "".join(frame.lines(feature["geometry"]) for feature in wards)
    town_paths = "".join(frame.area(feature["geometry"]) for feature in towns)
    road_paths = "".join(
        frame.lines(feature["geometry"]) for feature in [*roads, *landmarks]
    )
    town_x, town_y = frame.project(TOWN_LABEL)
    boundary = along([frame.project(point) for point in outline], LABEL_CLEARANCE / 2)
    left, top_edge = frame.project((west + MARGIN, north - MARGIN))
    right, bottom = frame.project((east - MARGIN, south + MARGIN))
    road_labels = road_names(
        frame,
        roads,
        streets,
        [
            *keep_clear(
                town_x - TOWN_LABEL_WIDTH / 2, town_x + TOWN_LABEL_WIDTH / 2, town_y
            ),
            *keep_clear(office_x, office_x + OFFICE_LABEL_WIDTH, office_y),
            *boundary,
        ],
        (left, top_edge, right, bottom),
    )
    return f"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {WIDTH} {frame.height}" role="img" aria-labelledby="ward-map-title">
<title id="ward-map-title">Map of Ward {WARD}, St. Tammany Parish: most of the town of Abita Springs and the area north and east of it, with the court office marked.</title>
<path class="neighbor" d="{neighbors}"/>
<path class="ward" d="{frame.area(ward["geometry"])}"/>
<path class="town" d="{town_paths}"/>
<path class="road" d="{road_paths}"/>
<path class="boundary" d="{frame.area(ward["geometry"])}"/>
{road_labels}
{landmark_names(frame, landmarks)}
<text class="town-name" x="{town_x:.0f}" y="{town_y:.0f}">Abita Springs</text>
<circle class="office" cx="{office_x:.1f}" cy="{office_y:.1f}" r="7"/>
<text class="office-name" x="{office_x + 13:.0f}" y="{office_y + 5:.0f}">Court office</text>
<path class="bar" d="M20 {bar_y}h{bar:.1f}m0 -5v10M20 {bar_y - 5}v10"/>
<text class="bar-name" x="{20 + bar + 8:.0f}" y="{bar_y + 5}">{SCALE_BAR_MILES} miles</text>
<text class="bar-name" x="{WIDTH - 32}" y="30">N ↑</text>
</svg>
"""


if __name__ == "__main__":
    TARGET.write_text(build())
    print(TARGET, TARGET.stat().st_size, "bytes")
