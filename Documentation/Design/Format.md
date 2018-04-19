- Song
  - id
  - name
  - length
  - releaseDate
  - -> publisher
  - -> album

```JSON
{
  "id": "507f191e810c19729de860ea",
  "name": "Legend Has It",
  "length": "3:25",
  "releaseDate": "", // if empty check album or duplicate and ignore empty?
  "publisher": {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc."}, // can be empty?
  "album": {"id": "132sdafasdfas123as97ahjg", "name": "Run The Jewels 3"} // can also be empty?
}
```


- Album
  - id
  - name
  - totalLength
  - genre
  - releaseDate
  - songs[...]
  - -> publisher
  - -> artist

```JSON
{
  "id": "132sdafasdfas123as97ahjg",
  "name": "Run The Jewels 3",
  "totalLength": "51:27",
  "genre": "Hip hop/Rap", // turn into (list of) id?
  "releaseDate": "2016-12-24",
  "songs": [
    {"id": "507f191e810c19729de860ea", "name": "Legends Has It"},
    ...
  ],
  "publisher": {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc.",
  "artist": {"id": "116fn30gttdbor64nd63hgkw", "name": "Run The Jewels"
}
```


- Artist
  - name
  - genre
  - songs[...]
  - albums[...]
  - publishers[...]

```JSON
{
  "id": "507f191e810c19729de860ea",
  "name": "Legend Has It",
  "genre": "Hip hop/Rap", // can be (list of) ids?
  "songs": [
    {"id": "507f191e810c19729de860ea", "name": "Legends Has It"},
    ...
  ],
  "albums": [
    {"id": "132sdafasdfas123as97ahjg", "name": "Run The Jewels 3"},
    ...
  ],
  "publishers": [
    {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc."},
    ...
  ],
}
```


- Publisher
  - id
  - name

```JSON
{
  "id": "18b9t6dnr04zfdp37tnvopur",
  "name": "Run The Jewels, Inc."
}
```
