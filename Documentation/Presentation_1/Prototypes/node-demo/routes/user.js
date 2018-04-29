var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function (req, res, next) {
  // DB abfrage
  res.send(`
  {
    "id": "507f191e810c19729de860ea",
    "name": "Legend Has It",
    "length": "3:25",
    "releaseDate": "2016-12-24",
    "lyrics": "Hear what I say, we are the business today...",
    "URLs": [{
        "id": "skjdd3kje3jlklj3lej3lej3l",
        "name": "spotify",
        "link": "https://open.spotify.com/track/6bGwloiyyHXwFZ4yV1zjqR?si=kTT6pTAoSXK89xWVVLalJg"
      },
      {
        "id": "lwwfn3lrn3lnrl3n4l3n3ln3l",
        "name": "youtube",
        "link": "https://youtu.be/vWaljXUiCaE"
      }
    ],
    "genres": [{
      "id": "dskjdkjekljelkjelk343l4jl3",
      "name": "Hip Hop/Rap"
    }],
    "tags": [{
        "id": "lflwlejelwkjkwejrkj4330",
        "name": "Fussballhymne"
      },
      {
        "id": "dkskjdldjlwdjljwldl7wd2",
        "name": "BVB"
      }
    ],
    "publisher": {
      "id": "18b9t6dnr04zfdp37tnvopur",
      "name": "Run The Jewels, Inc."
    },
    "album": {
      "id": "132sdafasdfas123as97ahjg",
      "name": "Run The Jewels 3"
    },
    "artist": [{
      "id": "507f191e810c19729de860ea",
      "name": "Run The Jewels"
    }]
  }
  `);
});

module.exports = router;
