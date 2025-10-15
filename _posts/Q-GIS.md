# Adding mapy.cz tiles to the map

In the browser, right-click XYZ Tiles and choose New Connection. Name the connection, and in the URL field, paste the following URL:

```
https://api.mapy.cz/v1/maptiles/basic/256/{z}/{x}/{y}?apikey=<Your API key>
```

For authentication, select No authentication. Click OK.

Then, add tils to the layers by double-clicking the connection you just created.

For mapy.cz, the the API key can be obtained by registering at [https://developer.mapy.cz](https://developer.mapy.cz/account/projects).

Instead of `basic`, you can also use these [tiles](https://api.mapy.cz/v1/docs/maptiles/#/tiles/get_v1_maptiles__mapset___tileSize___z___x___y_): `basic`, `outdoor`, `winter`, `aerial`, `names-overlay`. 

Note that according to the FAQ, apparently tiles from mapy.cz can't be used in Q-GIS. 