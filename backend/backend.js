//REST-API
var express = require('express')
var app = express()
var HOST = process.env.HOST || '0.0.0.0'
var PORT = process.env.PORT || 3000

//MongoDB
var mongoose = require('mongoose')
mongoose.Promise = Promise
var dbUrl = process.env.DB_URL || 'mongodb://192.168.99.100:27017/test'

var Album     = require('./model/album.model')
var Song      = require('./model/song.model')
var Artist    = require('./model/artist.model')
var ArtistSong = require('./model/artistsong.album')
var ArtistAlbum = require('./model/artistalbum.model')

var albumList = []
var songList = []
var artistList = []
var artistSongList = []
var artistAlbumList = []

//API for Lyrics and Spotify
var lyrics = require('apiseeds-lyrics')
const apikey = 'FFt3VgRpKgiEhKCNQa9xndRidVhq4hU1vxAvcFaFWpm459AeMJkYbDw3ACvzIzA0'
var Spotify = require('node-spotify-api')
var spotify = new Spotify({
    id: 'ae3658a1c9764c5d8c30a0f99dd5d206',
    secret: '7482ac3e0de44a88bea99613157ae43e'
})

// API Endpoint for the newest albums on spotify
const newReleases = 'https://api.spotify.com/v1/browse/new-releases?country=SE&limit=3'

//Actual code
app.use(express.static(__dirname))
var server = app.listen(PORT, HOST, () => {
    console.log('server is listening on port', server.address().port)
})

console.log(process.env.DB_URL)
mongoose.connect(dbUrl, (err) => {
    console.log('mongo db connection', err)
})

updateDatabase()

//REST-Functions
app.get('/init', (req, res) => {
    var song = new Song({
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

function handleError(err) {
    console.log(err);
}

//Functions for DatabaseUpdateService

//Function Requests newest Albumreleases on Spotify and sets a Timer for the new Request
function updateDatabase() {
    spotify.request(newReleases).then(function(data) {
        if(data.albums.items) {
            console.log("albumlist received!")
            var albums = data.albums.items
            for (var pos in albums) {
                createAlbum(albums[pos].href)
            }
        }
        else {
            console.log("List not received!")
        }

        storeListEntries()
        
        console.log("Timer Set to 24 hours!")
        setTimeout(updateDatabase, 24 * 60 * 60 * 1000)
    })

    
}

//Requests Album and stores in List
function createAlbum(albumURL) {
    spotify.request(albumURL).then(function(data) {
        console.log("Album: " + albumURL )
        
        var nameTmp = ""
        var genresTmp = []
        var release_dateTmp = ""
        var imgTmp = ""
        var songs = []
        
        data.name ?
            nameTmp = data.name :
            console.log("Album: name not available!")
        data.genres ?
            genresTmp = data.genres :
            console.log("Album: genres not available")
        data.release_date ?
            release_dateTmp = data.release_date :
            console.log("Album: releaseDate not available")
        data.images[0].url ?
            imgTmp = data.images[0].url :
            console.log("Album: Image not available")

        var albumEntry = new Album({
            name: nameTmp,
            genre: genresTmp,
            releaseDate: release_dateTmp,
            img: imgTmp
        })

        albumList.push(albumEntry)

        data.tracks.items ? songs = data.tracks.items : console.log("Songlist not available!")
        for (pos in songs) {
            createSong(songs[pos])
        }

        data.artists ?
            createArtistAlbumRef(data.artists, albumEntry.name) :
            console.log("No Artists found!")
    })
}

//Creates Reference between Album and Artists
function createArtistAlbumRef(artists, albumRef) {
    for (var pos in artists) {
        var artistAlbumEntry = new ArtistAlbum({
            album: albumRef,
            artist: artists[pos].name
        })
        artistAlbumList.push(artistAlbumEntry)
    }
}

//Stores Songinformation in List
function createSong(song){
    var artists = []
    var lyricsRes = ""
    var nameTmp = ""
    var duration_msTmp = ""
    var release_dateTmp = ""
    var uriTmp = ""

    console.log("Song: " + song.href)
    
    song.name ?
        nameTmp = song.name :
        console.log("Song: Name not found!")
    song.duration_ms ?
        duration_msTmp = song.duration_ms :
        console.log("Song: Duration_ms not found!")
    song.release_date ?
        release_dateTmp = song.album.release_date :
        console.log("Song: Release_date not found!")
    song.uri ?
        uriTmp = song.uri :
        console.log("Song: Spotify URI not found!")
    
    if (song.artists[0] && song.name) {
        artists = song.artists

        lyrics.getLyric(apikey, artists[0].name, song.name, function(response, headers) {

            response.error ? 
                console.log("ERROR FOUND:", response) : 
                lyricsRes = response.result.track.text

            var songEntry = new Song({
                name: nameTmp,
                length: duration_msTmp,
                releaseDate: release_dateTmp,
                lyrics: lyricsRes,
                urls: [{
                    name: 'Spotify',
                    link: uriTmp
                }]
            })
        })
        createArtist(artists)
        createArtistSongRef(artists, nameTmp)
    }
    else {
        console.log("Song: Lyrics could not be requested!")
    }
}

//Requests Artist and stores in List
function createArtist(artists) {
    var existing = false
    for (pos in artists) {
        var x = 0
        while (artistList[x] && !existing) {
            if (artistList[x].name === artists[pos].name) {
                existing = true
            }
        }
        
        if (!existing) {
            spotify.request(artists[pos].href).then(function(artist){
                var artistEntry = new Artist({
                    name: artist.name,
                    genre: artist.genres
                })
                artistList.push(artistEntry)
            })
        }
    }
}

//Creates Reference between Song and Artists
function createArtistSongRef(artists, songRef) {
    for (var pos in artists) {
        var artistSongEntry = new ArtistSong({
            song: songRef,
            artist: artists[pos].name
        })
        artistSongList.push(artistSongEntry)
    }
}

function storeListEntries() {
    var entry

    while (songList) {
        entry = songList.pop()
        entry.save(function(err, saved){
            if (err) return handleError(err)
        })
    }
    while (albumList) {
        entry = albumList.pop()
        entry.save(function(err, saved){
            if (err) return handleError(err)
        })
    }
    while (artistAlbumList) {
        entry = artistAlbumList.pop()
        entry.save(function(err, saved){
            if (err) return handleError(err)
        })
    }
    while (artistList) {
        entry = artistList.pop()
        entry.save(function(err, saved){
            if (err) return handleError(err)
        })
    }

    console.log("Entries stored in MongoDB!")
    clearListEntries()
}