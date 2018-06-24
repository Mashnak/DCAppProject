/******************************************** MongoDB **************************************************/
var mongoose = require('mongoose')
var dbUrl = process.env.DB_URL || 'mongodb://192.168.99.100/test'

var Album = require('./model/album.model')
var Song = require('./model/song.model')
var Artist = require('./model/artist.model')
var ArtistSong = require('./model/artistsong.model')
var ArtistAlbum = require('./model/artistalbum.model')

console.log(dbUrl)
mongoose.connect(dbUrl, (err) => {
    if (err) {
        console.log('mongo db connection', err)
    }
    else {
        console.log('mongo db connection successful')
    }
})

/************************************ API for Updateservice ********************************************/
//API for getting Lyrics
var lyrics = require('apiseeds-lyrics')
const lyricsApikey = 'FFt3VgRpKgiEhKCNQa9xndRidVhq4hU1vxAvcFaFWpm459AeMJkYbDw3ACvzIzA0'

// API Endpoint for the newest albums on Spotify and Spotify API
const newReleases = 'https://api.spotify.com/v1/browse/new-releases?limit=3'
var Spotify = require('node-spotify-api')
var spotify = new Spotify({
    id: 'ae3658a1c9764c5d8c30a0f99dd5d206',
    secret: '7482ac3e0de44a88bea99613157ae43e'
})

// API for YouTube
var youtube = require('youtube-search');
var youtubeOpts = {
    maxResults: 1,
    key: 'AIzaSyDDHG1T1Ms8wtSIQK-v9qesuiYrug3KyHs'
};

/************************************** Monitoring Service *********************************************/

//Monitoring variables
const STATUS = 1
var m_msID = ""
var m_appID = ""
var statusLogs = []

var eventOptions = {
    url: {},
    method: "POST",
    json: {}
}

//REST-API
const url = require('url')
var request = require('request')
var express = require('express')
var app = express()
var bodyParser = require('body-parser')

var HOST = process.env.HOST || '0.0.0.0'
var PORT = process.env.PORT || 3000

//REST-Functions
app.use(express.static(__dirname))
var server = app.listen(PORT, HOST, () => {
    console.log('server is listening on port', server.address().port)
})

app.use(bodyParser.json())
app.post('/', function (req, res) {
    console.log('AliveStatus received!')

    var parsed = ""
    
    if (req.body.eventUrl.startsWith('http://')) {
        parsed = url.parse(req.body.eventUrl)
    }
    else {
        parsed = url.parse('http://' + req.body.eventUrl)
    }

    m_msID = req.body.msID
    m_appID = req.body.appID
    req.body.status = STATUS

    eventOptions.url = parsed

    res.send(req.body)
    monitoringPost()
})

function monitoringPost() {
    console.log("MonitoringPost started")

    if (statusLogs.length == 0) {
        console.log("I WAS EMPTY ALL ALONG!")
    }

    while (statusLogs.length > 0) {
        eventOptions.json = statusLogs.pop()
        eventOptions.json.microServiceID = m_msID
        eventOptions.json.appID = m_appID

        request(eventOptions, function (error, response, body) {
            if (error) {
                console.log('An error occured while trying to send a Request')
                console.log(error)
            }
            else {
                console.log("successfully sent Post-Request to Monitoring Service!")
            }
        })

    }

    console.log("Timer for next iteration started!")
    setTimeout(monitoringPost, 60 * 1000)
}

//Actual code
updateDatabase()


/***************************** Functions for Updateservice *********************************************/

//Function Requests newest Albumreleases on Spotify and sets a Timer for the new Request
function updateDatabase() {
    spotify.request(newReleases).then(function (data) {
        if (data.albums.items) {
            console.log("albumlist received with length:", data.albums.items.length)

            statusLogs.push({
                eventName: "NodeJs",
                description: "Received " + data.albums.items.length + " Albums from Spotify-API",
                errorTag: false,
                appID: "",
                microServiceID: "",
                timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
            })

            var albums = data.albums.items
            for (var pos in albums) {
                createAlbum(albums[pos].href)
            }
        }
        else {

            statusLogs.push({
                eventName: "NodeJs",
                description: "Could not receive Albums from Spotify-API",
                errorTag: true,
                appID: "",
                microserviceID: "",
                timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
            })

            console.log("List not received!")
        }


        statusLogs.push({
            eventName: "NodeJs",
            description: "Timer set for the Next Update of the Database to 24 hours!",
            errorTag: true,
            appID: "",
            microserviceID: "",
            timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
        })

        console.log("Timer Set to 24 hours!")
        setTimeout(updateDatabase, 24 * 60 * 60 * 1000)
    })
}

//Requests Album and stores in List
function createAlbum(albumURL) {
    spotify.request(albumURL).then(function (data) {
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

        console.log("Attempting to Store Album " + nameTmp)

        albumEntry.save(function (err, saved) {
            if (err) {
                statusLogs.push({
                    eventName: "NodeJs",
                    description: "Failed to store the Album " + nameTmp,
                    errorTag: true,
                    appID: "",
                    microServiceID: "",
                    timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                })
                return handleError(err)
            }
            else {
                statusLogs.push({
                    eventName: "NodeJs",
                    description: "Album " + nameTmp + " stored successfully",
                    errorTag: false,
                    appID: "",
                    microServiceID: "",
                    timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                })
                console.log("Album stored sucessfully!")
            }
        })

        data.tracks.items ? songs = data.tracks.items : console.log("Songlist not available!")
        console.log("Album: includes " + songs.length + "songs")
        for (pos in songs) {
            createSong(songs[pos], release_dateTmp, albumEntry.img, albumEntry.name, genresTmp)
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
        artistAlbumEntry.save(function (err, saved) {
            if (err) return handleError(err)
            else console.log("AlbumRef stored sucessfully!")
        })
    }
}

//Stores Songinformation in List
function createSong(song, release, image, albumRef, genreList) {
    var artists = []
    var nameTmp = ""
    var duration_msTmp = ""
    var lyricsRes = ""
    var spotifyUriTmp = ""
    var youtubeUriTmp = ""

    console.log("Song: " + song.href)

    song.name ?
        nameTmp = song.name :
        console.log("Song: Name not found!", song)
    song.duration_ms ?
        duration_msTmp = song.duration_ms :
        console.log("Song: Duration_ms not found!", song)

    if (!release) { console.log("Song: Release_date not found!", song) }

    song.external_urls.spotify ?
        spotifyUriTmp = song.external_urls.spotify :
        console.log("Song: Spotify URI not found!", song)

    if (song.artists[0] && song.name) {
        artists = song.artists

        lyrics.getLyric(lyricsApikey, artists[0].name, song.name, function (response, headers) {
            if (response.error) {
                console.log("ERROR FOUND:", response)
                statusLogs.push({
                    eventName: "NodeJs",
                    description: "Could not receive Lyrics for " + artists[0].name + " - " + song.name,
                    errorTag: true,
                    appID: "",
                    microServiceID: "",
                    timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                })
            }
            else {
                statusLogs.push({
                    eventName: "NodeJs",
                    description: "Received Lyrics for " + artists[0].name + " - " + song.name,
                    errorTag: false,
                    appID: "",
                    microServiceID: "",
                    timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                })
                lyricsRes = response.result.track.text
            }
            youtube(artists[0].name + ' ' + nameTmp, youtubeOpts, function (err, results) {

                if (err) {
                    statusLogs.push({
                        eventName: "NodeJs",
                        description: "Could not find YouTube-Link for " + artists[0].name + " - " + nameTmp,
                        errorTag: true,
                        appID: "",
                        microServiceID: "",
                        timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                    })
                    return console.log(err)
                } else {
                    statusLogs.push({
                        eventName: "NodeJs",
                        description: "Found YouTube-Link for " + artists[0].name + " - " + nameTmp,
                        errorTag: false,
                        appID: "",
                        microServiceID: "",
                        timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                    })
                }

                results[0].link ? youtubeUriTmp = results[0].link : console.log("No Youtube Link found!")

                var songEntry = new Song({
                    name: nameTmp,
                    length: duration_msTmp,
                    releaseDate: release,
                    lyrics: lyricsRes,
                    link: [{
                        name: 'Spotify',
                        url: spotifyUriTmp
                    }, {
                        name: 'YouTube',
                        url: youtubeUriTmp
                    }],
                    img: image,
                    genre: genreList,
                    album: albumRef
                })

                songEntry.save(function (err, saved) {
                    if (err) {
                        statusLogs.push({
                            eventName: "NodeJs",
                            description: "Could not store Song " + artists[0].name + " - " + nameTmp,
                            errorTag: true,
                            appID: "",
                            microServiceID: "",
                            timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                        })

                        return handleError(err)
                    }
                    else {
                        statusLogs.push({
                            eventName: "NodeJs",
                            description: "Sucessfully stored Song " + artists[0].name + " - " + nameTmp,
                            errorTag: false,
                            appID: "",
                            microServiceID: "",
                            timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                        })

                        console.log("Song stored sucessfully!")
                    }
                })
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
        spotify.request(artists[pos].href).then(function (artist) {
            var artistEntry = new Artist({
                name: artist.name,
                genre: artist.genres,
                img: artist.images[0].url
            })

            artistEntry.save(function (err, saved) {
                if (err) {
                    statusLogs.push({
                        eventName: "NodeJs",
                        description: "Could not store Artist " + artist.name,
                        errorTag: true,
                        appID: "",
                        microServiceID: "",
                        timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                    })
                    return handleError(err)
                }
                else {
                    statusLogs.push({
                        eventName: "NodeJs",
                        description: "Successfully stored Artist " + artist.name,
                        errorTag: false,
                        appID: "",
                        microServiceID: "",
                        timestamp: new Date().toISOString().replace(/T/, ' ').replace(/Z/, '')
                    })
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
        artistSongEntry.save(function (err, saved) {
            if (err) return handleError(err)
            else console.log("SongReference stored sucessfully!")
        })
    }
}

function handleError(err) {
    console.log("Not Successful!");
}