# JSON - Example

Examples for JSON Files that might be stored in our Database

## Song

- id
- name
- length
- releaseDate
- lyrics
- -> URLs[...]
- -> genres[...]
- -> tags[...]
- -> publisher
- -> album
- -> artists[...]

```JSON
{
  "id": "507f191e810c19729de860ea",
  "name": "Legend Has It",
  "length": "3:25",
  "releaseDate": "2016-12-24",
  "lyrics": "Hear what I say, we are the business today...",
  "URLs":[
    {"id": "skjdd3kje3jlklj3lej3lej3l", "name":"spotify","link":"https://open.spotify.com/track/6bGwloiyyHXwFZ4yV1zjqR?si=kTT6pTAoSXK89xWVVLalJg"},
    {"id": "lwwfn3lrn3lnrl3n4l3n3ln3l", "name":"youtube", "link":"https://youtu.be/vWaljXUiCaE"}
    ...
  ],
  "genres":[
    {"id": "dskjdkjekljelkjelk343l4jl3", "name": "Hip Hop/Rap"}
    ...
  ],
  "tags":[
    {"id": "lflwlejelwkjkwejrkj4330", "name": "Fussballhymne"},
    {"id": "dkskjdldjlwdjljwldl7wd2", "name": "BVB"}
    ...
  ],
  "publisher": {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc."},
  "album": {"id": "132sdafasdfas123as97ahjg", "name": "Run The Jewels 3"},
  "artist": [
    {"id": "507f191e810c19729de860ea", "name": "Run The Jewels"},
    ...
  ],
}
```

## Album

- id
- name
- totalLength
- releaseDate
- genres[...]
- tags[...]
- songs[...]
- -> artists[...]
- -> publisher

```JSON
{
  "id": "132sdafasdfas123as97ahjg",
  "name": "Run The Jewels 3",
  "totalLength": "51:27",
  "releaseDate": "2016-12-24",
  "genres": [
    {"id":"ldjflkejieij343l4l3jldjl", "name":"Hip hop/Rap"}
    ...
  ],
  "tags":[
    {"id": "lflwlejelwkjkwejrkj4330", "name": "Fussballhymne"},
    {"id": "dkskjdldjlwdjljwldl7wd2", "name": "BVB"}
    ...
  ],
  "songs": [
    {"id": "507f191e810c19729de860ea", "name": "Legends Has It"}
    ...
  ],
  "artists": [
    {"id": "116fn30gttdbor64nd63hgkw", "name": "Run The Jewels"}
    ...
  ],
  "publisher": {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc."}
}
```

## Artist

- id
- name
- genre[...]
- tags[...]
- songs[...]
- albums[...]
- publishers[...]

```JSON
{
  "id": "507f191e810c19729de860ea",
  "name": "Run The Jewels",
  "genres": [
    {"id":"ldjflkejieij343l4l3jldjl", "name":"Hip hop/Rap"}
  ],
  "tags":[
    {"id": "lflwlejelwkjkwejrkj4330", "name": "Fussballhymne"},
    {"id": "dkskjdldjlwdjljwldl7wd2", "name": "BVB"}
  ],
  "songs": [
    {"id": "507f191e810c19729de860ea", "name": "Legend Has It"}
    ...
  ],
  "albums": [
    {"id": "132sdafasdfas123as97ahjg", "name": "Run The Jewels 3"}
    ...
  ],
  "publishers": [
    {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc."}
    ...
  ]
}
```

## Publisher

- id
- name
- genre[...]
- tags[...]
- -> Songs[...]
- -> Albums[...]
- -> Artists[...]

```JSON
{
  "id": "18b9t6dnr04zfdp37tnvopur",
  "name": "Run The Jewels, Inc.",
  "tags":[
    {"id": "lflwlejelwkjkwejrkj4330", "name": "Fussballhymne"},
    {"id": "dkskjdldjlwdjljwldl7wd2", "name": "BVB"}
  ],
  "genres": [
    {"id":"ldjflkejieij343l4l3jldjl", "name":"Hip hop/Rap"}
  ],
  "songs": [
    {"id": "507f191e810c19729de860ea", "name": "Legends Has It"}
    ...
  ],
  "albums": [
    {"id": "132sdafasdfas123as97ahjg", "name": "Run The Jewels 3"}
    ...
  ],
  "artists": [
    {"id": "116fn30gttdbor64nd63hgkw", "name": "Run The Jewels"}
    ...
  ]
}
```

## Genre

- id
- name

 ```JSON
{
  "id": "18b9t6dnr04zfdp37tnvopur",
  "name": "HipHop/Rap"
}
```

## Tags

- id
- name

```JSON
{
  "id": "18b9t6dnr04zfdp37tnvopur",
  "name": "Fussballhymne"
}
```

## Comment

- id
- text
- timestamp
- -> User
- -> Album
- -> Song
- -> Artist
- -> Comments[...]

```JSON
{
  "id": "dhfodfhsekjdhf8445230wh0h38",
  "name": "User",
  "text": "Nice Song!",
  "timestamp": "2018-04-23",
  "Album": {},
  "Song": {"id": "djfksjkje29u13j2lj1l", "name": "Legends Has it"},
  "Artist": {},
  "Comments": [
    {"id": "skdjhdejhhuhe82heuh92"},
    {"id": "skdjhaaaaswhe2hwdkjj2"}
  ]
}
```

## User

- id
- Username
- FirstName
- LastName
- Birthdate
- Gender
- Country
- isAdmin

```JSON
{
  "id": "wehewjh30ejo4jfjkfd4j04f",
  "name": "Hot Chocolate",
  "FirstName": "Khaled",
  "LastName": "Ahmed",
  "Birthdate": "1994-12-23",
  "Gender": "male",
  "Country": "Germany",
  "isAdmin": "true"
}
```

## UserSearch

- -> Users[...]

```JSON
{
  "Users":[
    {
      "id": "kjsdljllj3l432lje2lj23l2j",
      "name": "User",
      "FirstName": "Peter",
      "LastName": "Enis",
      "Birthdate": "1985-05-12",
      "Gender": "",
      "Country": "Italy",
      "isAdmin": "false"
    },
    {
      "id": "wehewjh30ejo4jfjkfd4j04f",
      "name": "Hot Chocolate",
      "FirstName": "Khaled",
      "LastName": "Ahmed",
      "Birthdate": "1994-12-23",
      "Gender": "male",
      "Country": "Germany",
      "isAdmin": "true"
    },
    ...
  ]
}
```

## SongSearch

- -> Songs[...]

```JSON
{
  "Songs":[
    {
      "id": "507f191e810c19729de860ea",
      "name": "Legend Has It",
      "length": "3:25",
      "releaseDate": "2016-12-24",
      "lyrics": "Hear what I say, we are the business today...",
      "URLs":[
        {
          "id": "skjdd3kje3jlklj3lej3lej3l",
          "name":"spotify",
          "link":"https://open.spotify.com/track/6bGwloiyyHXwFZ4yV1zjqR?si=kTT6pTAoSXK89xWVVLalJg"
        },
        {"id": "lwwfn3lrn3lnrl3n4l3n3ln3l", "name":"youtube", "link":"https://youtu.be/vWaljXUiCaE"}
        ...
      ],
      "genres":[
        {"id": "dskjdkjekljelkjelk343l4jl3", "name": "Hip Hop/Rap"}
        ...
      ],
      "tags":[
        {"id": "lflwlejelwkjkwejrkj4330", "name": "Fussballhymne"},
        {"id": "dkskjdldjlwdjljwldl7wd2", "name": "BVB"}
        ...
      ],
      "publisher": {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc."},
      "album": {"id": "132sdafasdfas123as97ahjg", "name": "Run The Jewels 3"},
      "artist": [
        {"id": "507f191e810c19729de860ea", "name": "Run The Jewels"},
        ...
      ],
    },
    ...
  ]
}
```

## AlbumSearch

- -> Albums[...]

```JSON
{
  "Albums":
  [
    {
      "id": "132sdafasdfas123as97ahjg",
      "name": "Run The Jewels 3",
      "totalLength": "51:27",
      "releaseDate": "2016-12-24",
      "genres":
      [
        {"id":"ldjflkejieij343l4l3jldjl", "name":"Hip hop/Rap"}
        ...
      ],
      "tags":
      [
        {"id": "lflwlejelwkjkwejrkj4330", "name": "Fussballhymne"},
        {"id": "dkskjdldjlwdjljwldl7wd2", "name": "BVB"}
        ...
      ],
      "songs":
      [
        {"id": "507f191e810c19729de860ea", "name": "Legends Has It"},
        ...
      ],
      "artist":
      [
        {"id": "116fn30gttdbor64nd63hgkw", "name": "Run The Jewels"},
        ...
      ],
      "publisher": {"id": "18b9t6dnr04zfdp37tnvopur", "name": "Run The Jewels, Inc."}
    }
    ...
  ]
}
```

## ArtistSearch

- -> Artists[...]

```JSON
{
  "Artist":[
    {
      "id": "507f191e810c19729de860ea",
      "name": "Run The Jewels",
      "genres": [
        {"id":"ldjflkejieij343l4l3jldjl", "name":"Hip hop/Rap"}
        ...
      ],
      "tags":[
        {"id": "lflwlejelwkjkwejrkj4330", "name": "Fussballhymne"},
        {"id": "dkskjdldjlwdjljwldl7wd2", "name": "BVB"}
        ...
      ],
      "songs": [
        {"id": "507f191e810c19729de860ea", "name": "Legend Has It"},
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
    },
    ...
  ]
}
```

## PublisherSearch

- -> Publishers[...]

```JSON
{
  "Users":[
    {
      "id": "kjsdljllj3l432lje2lj23l2j",
      "name": "User",
      "FirstName": "Peter",
      "LastName": "Enis",
      "Birthdate": "1985-05-12",
      "Gender": "",
      "Country": "Italy",
      "isAdmin": "false"
    },
    {
      "id": "wehewjh30ejo4jfjkfd4j04f",
      "name": "Hot Chocolate",
      "FirstName": "Khaled",
      "LastName": "Ahmed",
      "Birthdate": "1994-12-23",
      "Gender": "male",
      "Country": "Germany",
      "isAdmin": "true"
    },
    ...
  ]
}
```
