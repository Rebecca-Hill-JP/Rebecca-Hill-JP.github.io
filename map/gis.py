"""St. Tammany Parish Government GIS layers: the one source of the ward map and the address list."""

import httpx

GIS = "https://maps.stpgov.org/server/rest/services/Referenced_Layers"
WARD = "10"
OFFICE_ADDRESS = "71667 LEVESON ST"


def query(layer: str, **params: str) -> list[dict]:
    """Return the GeoJSON features of one parish layer, in longitude and latitude unless `outSR` says otherwise."""
    defaults = {"where": "1=1", "outFields": "*", "outSR": "4326", "f": "geojson"}
    response = httpx.get(
        f"{GIS}/{layer}/MapServer/0/query", params=defaults | params, timeout=60
    )
    response.raise_for_status()
    return response.json()["features"]


def query_all(layer: str, **params: str) -> list[dict]:
    """Every matching feature of a layer too large for one response.

    Pages are keyed on OBJECTID, so no page depends on the server keeping its order.
    """
    features: list[dict] = []
    last = 0
    while page := query(
        layer, where=f"OBJECTID > {last}", orderByFields="OBJECTID", **params
    ):
        features += page
        last = page[-1]["properties"]["OBJECTID"]
    return features
