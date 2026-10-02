"""Draw src/assets/ward-10.svg from St. Tammany Parish Government GIS layers.

Run `npm run map` after the parish changes a ward boundary. Every shape comes
from the parish's own data, so the map cannot drift from the official boundary.
"""

import math
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
LABEL_INSET = 90  # pixels from the canvas edge inside which a road may be named
TOWN_LABEL = (
    -90.0290,
    30.4690,
)  # (longitude, latitude), chosen by eye inside the town limits

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


def road_names(frame: Frame, roads: list[dict], avoid: list[Point]) -> str:
    """Name each road at its vertex farthest from every other road, so names do not collide."""
    vertices: dict[str, list[Point]] = {}
    for road in roads:
        pixels = [
            frame.project(point) for run in rings(road["geometry"]) for point in run
        ]
        vertices.setdefault(road["properties"]["NAME"], []).extend(
            (x, y)
            for x, y in pixels
            if LABEL_INSET <= x <= WIDTH - LABEL_INSET
            and LABEL_INSET <= y <= frame.height - LABEL_INSET
        )
    labels = []
    for name, own in vertices.items():
        others = avoid + [
            pixel
            for other, pixels in vertices.items()
            if other != name
            for pixel in pixels
        ]
        if own:
            x, y = max(
                own, key=lambda pixel: min(math.dist(pixel, other) for other in others)
            )
            labels.append(
                f'<text class="road-name" x="{x + 8:.0f}" y="{y - 7:.0f}">{name}</text>'
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
    office = query("Address_Points", where=f"ADDRESS = '{OFFICE_ADDRESS}'")[0]
    office_x, office_y = frame.project(office["geometry"]["coordinates"])
    bar = SCALE_BAR_MILES * MILE * frame.meter
    bar_y = frame.height - 18
    neighbors = "".join(frame.lines(feature["geometry"]) for feature in wards)
    town_paths = "".join(frame.area(feature["geometry"]) for feature in towns)
    road_paths = "".join(frame.lines(feature["geometry"]) for feature in roads)
    town_x, town_y = frame.project(TOWN_LABEL)
    road_labels = road_names(frame, roads, [(office_x, office_y), (town_x, town_y)])
    return f"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {WIDTH} {frame.height}" role="img" aria-labelledby="ward-map-title">
<title id="ward-map-title">Map of Ward {WARD}, St. Tammany Parish: most of the town of Abita Springs and the area north and east of it, with the court office marked.</title>
<path class="neighbor" d="{neighbors}"/>
<path class="ward" d="{frame.area(ward["geometry"])}"/>
<path class="town" d="{town_paths}"/>
<path class="road" d="{road_paths}"/>
<path class="boundary" d="{frame.area(ward["geometry"])}"/>
{road_labels}
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
