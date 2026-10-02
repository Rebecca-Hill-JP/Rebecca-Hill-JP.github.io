"""`npm run map`: redraw the ward map and rebuild the address list from the same parish layers."""

from . import addresses, build

build.write()
addresses.write()
