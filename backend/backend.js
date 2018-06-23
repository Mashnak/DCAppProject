//REST-API
var express = require('express')
var app = express()
var HOST = process.env.HOST || '0.0.0.0'
var PORT = process.env.PORT || 3000

//MongoDB
var mongoose = require('mongoose')
var dbUrl = process.env.DB_URL || 'mongodb://192.168.99.100/test'

var Album     = require('./model/album.model')
var Song      = require('./model/song.model')
var Artist    = require('./model/artist.model')
var ArtistSong = require('./model/artistsong.model')
var ArtistAlbum = require('./model/artistalbum.model')

//API for Lyrics and Spotify
var lyrics = require('apiseeds-lyrics')
const apikey = 'FFt3VgRpKgiEhKCNQa9xndRidVhq4hU1vxAvcFaFWpm459AeMJkYbDw3ACvzIzA0'
var Spotify = require('node-spotify-api')
var spotify = new Spotify({
    id: 'ae3658a1c9764c5d8c30a0f99dd5d206',
    secret: '7482ac3e0de44a88bea99613157ae43e'
})

// API Endpoint for the newest albums on spotify
const newReleases = 'https://api.spotify.com/v1/browse/new-releases?limit=3'

//Actual code
app.use(express.static(__dirname))
var server = app.listen(PORT, HOST, () => {
    console.log('server is listening on port', server.address().port)
})

console.log(dbUrl)
mongoose.connect(dbUrl, (err) => {
    if(err) {
        console.log('mongo db connection', err)
    }
    else {
        console.log('mongo db connection successful')
    }
})

updateDatabase()

//REST-Functions


//Functions for DatabaseUpdateService

//Function Requests newest Albumreleases on Spotify and sets a Timer for the new Request
function updateDatabase() {
    spotify.request(newReleases).then(function(data) {
        if(data.albums.items) {
            console.log("albumlist received with length:", data.albums.items.length)
            var albums = data.albums.items
            for (var pos in albums) {
                createAlbum(albums[pos].href)
            }
        }
        else {
            console.log("List not received!")
        }
        console.log("Timer Set to 24 hours!")
        setTimeout(updateDatabase, 24 * 60 * 60 * 1000)
    })

    
}

//Requests Album and stores in List
function createAlbum(albumURL) {
    spotify.request(albumURL).then(function(data) {
        console.log("Album: " + albumURL)
        
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

        albumEntry.save(function(err, saved){
            if (err) return handleError(err)
            else console.log("Album stored sucessfully!")
        })

        data.tracks.items ? songs = data.tracks.items : console.log("Songlist not available!")
        console.log("Album: includes " + songs.length + "songs")
        for (pos in songs) {
            createSong(songs[pos], release_dateTmp, albumEntry.img,albumEntry.name, genresTmp)
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
        artistAlbumEntry.save(function(err, saved){
            if (err) return handleError(err)
            else console.log("AlbumRef stored sucessfully!")
        })
    }
}

//Stores Songinformation in List
function createSong(song, release, image, albumRef, genreList){
    var artists = []
    var nameTmp = ""
    var duration_msTmp = ""
    var lyricsRes = ""
    var uriTmp = ""
    var genresTmp = []

    console.log("Song: " + song.href)
    
    song.name ?
        nameTmp = song.name :
        console.log("Song: Name not found!", song)
    song.duration_ms ?
        duration_msTmp = song.duration_ms :
        console.log("Song: Duration_ms not found!", song)
    
    if (!release) { console.log("Song: Release_date not found!", song) }

    song.uri ?
        uriTmp = song.uri :
        console.log("Song: Spotify URI not found!", song)
    
    if (song.artists[0] && song.name) {
        artists = song.artists

        lyrics.getLyric(apikey, artists[0].name, song.name, function(response, headers) {
            response.error ?
                console.log("ERROR FOUND:", response) :
                lyricsRes = response.result.track.text

            var songEntry = new Song({
                name: nameTmp,
                length: duration_msTmp,
                releaseDate: release,
                lyrics: lyricsRes,
                link: [{
                    name: 'Spotify',
                    url: uriTmp
                }],
                img: image,
                genre: genreList,
                album: albumRef

            })
            songEntry.save(function(err, saved){
                if (err) return handleError(err)
                else console.log("Song stored sucessfully!")
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
        spotify.request(artists[pos].href).then(function(artist){
                var artistEntry = new Artist({
                    name: artist.name,
                    genre: artist.genres,
                    img: artist.images[0].url
                })
                artistEntry.save(function(err, saved){
                    if (err) {
                        return handleError(err)
                    }
                    else {
                        console.log("Artist stored sucessfully!")
                    }
                })
            })
    }
}

//Creates Reference between Song and Artists
function createArtistSongRef(artists, songRef) {
    for (var pos in artists) {
        var artistSongEntry = new ArtistSong({
            song: songRef,
            artist: artists[pos].name
        })
        artistSongEntry.save(function(err, saved){
            if (err) return handleError(err)
            else console.log("SongReference stored sucessfully!")
        })
    }
}

function handleError(err) {
    console.log(err);
}