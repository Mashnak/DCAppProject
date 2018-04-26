var express = require('express')
var app = express()
var mongoose = require('mongoose')

var PORT = 3000
var HOST = '0.0.0.0'
var dbUrl = 'mongodb://192.168.99.100:27017'

mongoose.Promise = Promise
var Schema = mongoose.Schema

var Song = mongoose.model('Song', {
    id: Schema.Types.ObjectId,
    name: String,
    length: String,
    releaseDate: String,
    lyrics: String,
    URLs: [{
        id: Schema.Types.ObjectId,
        name: String,
        link: String
    }],
    genres: [{
        id: Schema.Types.ObjectId,
        name: String
    }],
    tags: [{
        id: Schema.Types.ObjectId,
        name: String
    }],
    publisher: {
        id: Schema.Types.ObjectId,
        name: String
    },
    album: {
        id: Schema.Types.ObjectId,
        name: String
    },
    artists: [{
        id: Schema.Types.ObjectId,
        name: String
    }],
})

app.use(express.static(__dirname))

app.get('/song', (req, res) => {
    res.send('hi')
})

app.get('/song/:id', (req, res) => {
    var songid = req.params.id
    Song.find({
        id: songid
    }, (err, messages) => {
        res.send(messages)
    })
})

function handleError(err) {
    console.log(err);
}

app.get('/init', (req, res) => {
    var song = new Song({
        id: "507f191e810c19729de860ea",
        name: "Legend Has It",
        length: "3:25",
        releaseDate: "2016-12-24",
        lyrics: "Hear what I say, we are the business today...",
        URLs: [{
                id: "507f191e810c19729de860e1",
                name: "spotify",
                link: "https://open.spotify.com/track/6bGwloiyyHXwFZ4yV1zjqR?si=kTT6pTAoSXK89xWVVLalJg"
            },
            {
                id: "507f191e810c19729de860e2",
                name: "youtube",
                link: "https://youtu.be/vWaljXUiCaE"
            }
        ],
        genres: [{
            id: "507f191e810c19729de860e3",
            name: "Hip Hop/Rap"
        }],
        tags: [{
                id: "507f191e810c19729de860e4",
                name: "Fussballhymne"
            },
            {
                id: "507f191e810c19729de860e5",
                name: "BVB"
            }
        ],
        publisher: {
            id: "507f191e810c19729de860e6",
            name: "Run The Jewels, Inc."
        },
        album: {
            id: "507f191e810c19729de860e7",
            name: "Run The Jewels 3"
        },
        artists: [{
            id: "507f191e810c19729de860e8",
            name: "Run The Jewels"
        }]
    })

    song.save(function (err) {
        if (err) return handleError(err)
    })
    res.send('rest')
})

mongoose.connect(dbUrl, (err) => {
    console.log('mongo db connection', err)
})

var server = app.listen(PORT, HOST, () => {
    console.log('server is listening on port', server.address().port)
})
